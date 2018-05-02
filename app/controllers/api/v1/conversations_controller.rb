class Api::V1::ConversationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :index, :destroy]

  def create
    volunteer_id = current_user.id
    task_id = conv_params[:task_id]
    task = Task.find task_id
    task_user_id = task.user_id
    #check if conversation exist if yes load it
    if Conversation.between(volunteer_id, conv_params[:task_id]).present?
      conversation = Conversation.between(volunteer_id, task_id).first
      messages_response(conversation.id)
      #if not check if user dont volunteer on his own task
    elsif
      task_user_id == volunteer_id
      json_response "You can't volunteer on your own request", false, {}, :unprocessable_entity

    else
      #create conversation
      conversation = Conversation.new conv_params
      conversation.volunteer_id = volunteer_id
      conversation.task_owner_id = task_user_id
      if conversation.save
        #increase fulfilment counter
        Task.find(task_id).increment(:fulfilment_counter)
        messages_response(conversation.id)
      else
        json_response "Error finding or creating conversation", false, {}, :unprocessable_entity
      end
    end
  end


  def index
    if current_user.present?
      if params["conversation_id"].present?
        if Conversation.find(params["conversation_id"]).task_owner_id == current_user.id || Conversation.find(params["conversation_id"]).volunteer_id == current_user.id
          messages_response(params["conversation_id"])
        else
         json_response "You are not allowed to view this conversation", false, {}, :not_found
        end
      end
    else
      json_response "You Need to log in to vieew conversations", false, {}, :unauthenticated
    end
  end

  private
  def conv_params
      params.require(:conversation).permit :task_id
  end

  def messages_response(id)
    json_response "Messages in this conversation", true, { messages: Message.where(conversation_id: id)}, :ok
  end
end

