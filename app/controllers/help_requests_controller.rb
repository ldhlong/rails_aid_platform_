class HelpRequestsController < ApplicationController
  def index
    # Fetch help requests with fewer than 5 assigned users
    help_requests = HelpRequest.where("assigned_users_count < ?", 5)
  
    # Group by title and select the first entry in each group
    unique_requests = help_requests.group_by(&:title).values.map(&:first)
  
    render json: unique_requests
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
    @help_request = HelpRequest.find_by(request_count: params[:request_count])
    return render json: { error: 'Help request not found' }, status: :not_found unless @help_request

    accepted_by_user = params.dig(:help_request, :accepted_by_user)&.to_i

    if accepted_by_user.present?
      if @help_request.assigned_users_count < 5
        @help_request.increment!(:assigned_users_count)

        if @help_request.assigned_users_count >= 5
          @help_request.update(completion_status: true)
        end

        if @help_request.update(help_request_update_params)
          # Create a new conversation for each accepted user
          conversation = Conversation.create(
            sender_id: accepted_by_user,
            user_id: @help_request.user_id,
            help_request_id: @help_request.id
          )

          Message.create(
            body: "Let's start the conversation!",
            conversation_id: conversation.id,
            sender_id: accepted_by_user,
            user_id: @help_request.user_id
          )

          render json: { help_request: @help_request, conversation_id: conversation.id }, status: :ok
        else
          render json: { errors: @help_request.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: "Help request already has the maximum number of accepted users." }, status: :unprocessable_entity
      end
    else
      render json: { error: "Accepted by user is required." }, status: :unprocessable_entity
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
    params.require(:help_request).permit(:title, :request_type, :description, :latitude, :longitude, :user_id, :visible)
  end

  def help_request_update_params
    params.require(:help_request).permit(:accepted_by_user, :completion_status, :visible)
  end
end
