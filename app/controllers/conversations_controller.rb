class ConversationsController < ApplicationController
    def index
      user_id = params[:user_id]
      conversations = Conversation.where('sender_id = ? OR user_id = ?', user_id, user_id)
      render json: conversations.map { |conversation|
        last_message = conversation.messages.last
        {
          id: conversation.id,
          sender_id: conversation.sender_id,
          user_id: conversation.user_id,
          last_message: last_message ? last_message.body : '',
          updated_at: last_message ? last_message.created_at : conversation.updated_at
        }
      }
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
  