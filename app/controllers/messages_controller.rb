class MessagesController < ApplicationController
  before_action :set_message, only: %i[show update destroy]

  # GET /messages
  def index
    if params[:conversation_id]
      @messages = Message.where(conversation_id: params[:conversation_id])
      render json: @messages
    else
      # Fetch unique conversations for the current user
      @conversations = Message
                        .select('DISTINCT ON (conversation_id) conversation_id, sender_id, user_id AS receiver_id')
                        .where('sender_id = ? OR user_id = ?', accepted_by_user, accepted_by_user)
      render json: @conversations
    end
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    # Fetch the associated help request and set sender_id
    help_request = HelpRequest.find_by(request_count: params[:message][:conversation_id])
    if help_request
      accepted_by_user = help_request.accepted_by_user
      @message.sender_id = accepted_by_user  # Set sender_id from help request's accepted_by_user

      @message.user_id = help_request.user_id  # Set user_id (receiver_id) from help request
    else
      render json: { error: "Help request not found" }, status: :unprocessable_entity
      return
    end
    
    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body, :conversation_id, :user_id, :sender_id)
  end

  def accepted_by_user
    params[:message][:accepted_by_user]  # Assuming accepted_by_user is sent from the frontend
  end
end
