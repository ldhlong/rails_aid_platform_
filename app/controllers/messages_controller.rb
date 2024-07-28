class MessagesController < ApplicationController
  before_action :set_message, only: %i[show update destroy]

  # GET /messages
  def index
    user_id = params[:user_id] # Correctly use sender_id from params
    if user_id.present?
      @messages = Message.select(:conversation_id, :sender_id, :user_id, :body, :created_at)
                         .where('sender_id = :user_id OR user_id = :user_id', user_id: user_id)
                         .order(conversation_id: :asc, created_at: :desc)
                         .distinct
                         .group_by(&:conversation_id)
                         .map { |_key, group| group.first } # Select the first message (last by created_at) for each conversation_id
      render json: @messages
    else
      render json: { error: 'user_id is required' }, status: :unprocessable_entity
    end
  end

  # GET /messages/:conversation_id
  def show_by_conversation
    conversation_id = params[:conversation_id]
    if conversation_id.present?
      @messages = Message.where(conversation_id: conversation_id)
                         .order(created_at: :desc)
      render json: @messages
    else
      render json: { error: 'conversation_id is required' }, status: :unprocessable_entity
    end
  end
  
  # POST /messages
  def create
    @message = Message.new(message_params)
    current_user_id = params[:user_id]

    # Fetch the associated help request
    help_request = HelpRequest.find_by(conversation_id: params[:conversation_id])

    if help_request
      conversation = Conversation.find_by(id: params[:conversation_id])
      
      if conversation
        if current_user_id.to_i == conversation.sender_id
          @message.sender_id = conversation.sender_id
          @message.user_id = conversation.user_id
        else
          @message.sender_id = current_user_id.to_i
          @message.user_id = conversation.sender_id
        end
      else
        render json: { error: "Conversation not found" }, status: :unprocessable_entity
        return
      end

      if @message.save
        render json: @message, status: :created
      else
        render json: @message.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Help request not found" }, status: :unprocessable_entity
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body, :conversation_id, :user_id, :sender_id)
  end
end
