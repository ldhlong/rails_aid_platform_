class ConversationsController < ApplicationController
  def index
    user_id = params[:user_id]
  
    # Fetch conversations where either sender_id or user_id matches the provided user_id
    conversations = Conversation.where('sender_id = ? OR user_id = ?', user_id, user_id)
  
    # Ensure that only conversations with both user_id and sender_id are included
    filtered_conversations = conversations.select do |conversation|
      conversation.sender_id.present? && conversation.user_id.present?
    end
  
    # Fetch help request details and merge with conversation data
    render json: filtered_conversations.map do |conversation|
      last_message = conversation.messages.last
      help_request = HelpRequest.find_by(request_count: conversation.help_request_id) # Use help_request_id here
      {
        id: conversation.id,
        sender_id: conversation.sender_id,
        user_id: conversation.user_id,
        last_message: last_message ? last_message.body : '',
        updated_at: last_message ? last_message.created_at : conversation.updated_at,
        help_request_id: conversation.help_request_id,
        created_at: help_request ? help_request.created_at : nil,
        completion_status: help_request ? help_request.completion_status : nil,
        visible: help_request ? help_request.visible : true,
        assigned_users_count: help_request ? help_request.assigned_users_count : nil
      }
    end
  end
  
  def user_id
    conversation = Conversation.find_by(id: params[:conversation_id])
    if conversation
      render json: { user_id: conversation.user_id }
    else
      render json: { error: "Conversation not found" }, status: :not_found
    end
  end
end
