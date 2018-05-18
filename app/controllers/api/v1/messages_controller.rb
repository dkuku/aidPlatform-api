class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :index, :destroy]

  def create
    puts params
    user_id = current_user.id
    conv_id = params[:conversation_id]
    #check if conversation exist and it 
    if Conversation.find( conv_id).present?
        conv = Conversation.find(conv_id)
        if  conv.volunteer_id == user_id || conv.task_owner_id == user_id
            message = Message.new
            message.body = message_params["body"]
            message.conversation_id = conv_id
            message.task_owner_id = conv.task_owner_id
            message.task_id = conv.task_id
            message.volunteer_id = conv.volunteer_id
            if conv.task_owner_id == user_id
              message.owner = true
            end
            puts message.to_json
            if message.save
                json_response "message created", true, {messages: message  }, :ok
            else
                json_response "Something wrong", false, {}, :unprocessable_entity
            end
        else
            json_response "You're not allowed to reply to this conversation", false, {}, :forbidden
        end
    else   
        json_response "Conversation not found", false, {}, :not_found
    end
end

    def index
        if current_user.present?
            json_response "Your Messages", true, {messages: Message.where(task_owner_id: current_user.id).or(Message.where(volunteer_id: current_user.id)).all}, :ok
        else
            json_response "You need to log in ", false, {}, :not_found
        end
    end
    private
      def message_params
          params.require(:message).permit :body
      end
end

