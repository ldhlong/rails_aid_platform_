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
      render json: { message: 'Help request submitted successfully' }, status: :created
    else
      render json: { errors: help_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    help_request = HelpRequest.find(params[:request_count])
    previous_status = help_request.completion_status
    accepted_by_user = params[:help_request][:accepted_by_user]

    Rails.logger.debug "Accepted by user: #{accepted_by_user}"

    if help_request.update(help_request_update_params.merge(accepted_by_user: accepted_by_user))
      # Create a new conversation and message
      conversation = Conversation.create(
        sender_id: accepted_by_user, 
        user_id: help_request.user_id
      )

      Rails.logger.debug "Conversation created with sender_id: #{conversation.sender_id} and user_id: #{conversation.user_id}"

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
    render json: { completed_requests_count: count }
  end

  private

  def current_user_id
    # Retrieve user_id from the current session or authentication context
    current_user.id
  end

  def help_request_params
    params.require(:help_request).permit(:title, :request_type, :description, :latitude, :longitude)
  end

  def help_request_update_params
    params.require(:help_request).permit(:accepted_by_user, :completion_status)
  end
end
