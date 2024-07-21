require 'securerandom'

class HelpRequestsController < ApplicationController
  def index
    help_requests = HelpRequest.all
    render json: help_requests
  end

  def show
    help_request = HelpRequest.find(params[:id])
    render json: help_request
  end
  
  def create
    help_request = HelpRequest.new(help_request_params.merge(user_id: current_user_id))

    if help_request.save
      # Create a new conversation and associate its ID with the help_request
      conversation = Conversation.create(
        sender_id: help_request.user_id,
        user_id: nil,  # Set to nil initially since accepted_by_user is nil
        help_request_id: help_request.id
      )

      # Update help_request with conversation_id
      help_request.update(conversation_id: conversation.id)

      Message.create(
        body: "Let's start the conversation!",
        conversation_id: conversation.id,
        sender_id: help_request.user_id,
        user_id: nil  # Set to nil initially since accepted_by_user is nil
      )

      render json: help_request, status: :created
    else
      render json: { errors: help_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    help_request = HelpRequest.find_by(request_count: params[:request_count])
    accepted_by_user = params[:help_request][:accepted_by_user]

    if help_request.update(help_request_update_params.merge(accepted_by_user: accepted_by_user))
      # Check if conversation already exists for this help_request
      conversation = Conversation.find_or_create_by(help_request_id: help_request.id) do |conv|
        conv.sender_id = accepted_by_user
        conv.user_id = help_request.user_id
      end

      # Update help_request with conversation_id
      help_request.update(conversation_id: conversation.id)

      Message.create(
        body: "Let's start the conversation!",
        conversation_id: conversation.id,
        sender_id: accepted_by_user,
        user_id: help_request.user_id
      )

      render json: help_request, status: :ok
    else
      render json: { errors: help_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def completed_requests_count
    count = HelpRequest.where(completion_status: true).count
    Rails.logger.debug "Completed requests count: #{count}"
    render json: { count: count }
  end

  private

  def current_user_id
    # Retrieve user_id from local storage or session
    params[:help_request][:user_id]  # Adjust this to your actual method of retrieving user_id from local storage
  end

  def help_request_params
    params.require(:help_request).permit(:title, :request_type, :description, :latitude, :longitude, :user_id)
  end

  def help_request_update_params
    params.require(:help_request).permit(:accepted_by_user, :completion_status)
  end
end
