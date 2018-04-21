class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :index, :destroy]

  def create
    sender_id = current_user.id
    #check if conversation exist and it belongs to user or task belongs to user
    if Conversation.where(id:, message_params[:conversation_id]).present?
        conv = Conversation.where(id:, message_params[:conversation_id])
        task = Task.where(id: conv.task_id)
        if  conv.user_id == sender_id OR task.user_id == sender_id
            message = Message.new message_params
            message.user_id = sender_id
            if message.save
                json_response "conversation created", true, {conversation: conversation, sender:{}, recipient: {}  }, :ok
            end
        else
            json_response "You're not allowed to reply to this conversation", false, {}, :forbidden
        end
    else   
        json_response "Conversation not found", false, {}, :not_found
    end
       
  private
  def message_params
      params.require(:message).permit :conversation_id, :body
  end
end

