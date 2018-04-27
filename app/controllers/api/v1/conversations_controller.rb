class Api::V1::ConversationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :index, :destroy]

  def create
    volunteer_id = current_user.id
    task_id = conv_params[:task_id]
    #check if task exist
    if Task.find(task_id).present?
      task_user_id = Task.find(task_id).user_id
      #check if conversation exist if yes load it
      if Conversation.between(volunteer_id, conv_params[:task_id]).present?
        conversation = Conversation.between(volunteer_id, task_user_id).first
        json_response "Conversation found", true, {conversation: {messages: Message.where(conversation_id: conversation.id)}}, :ok
        #if not check if user dont volunteer on his own task
      elsif Task.find(task_id).user_id == current_user.id
          json_response "You can't Volunteer on your own request", false, {}, :unprocessable_entity
      else
        #create conversation
        conversation = Conversation.new conv_params
        conversation.volunteer_id = volunteer_id
        conversation.task_owner_id = task_user_id
        if conversation.save
          json_response "Conversation created", true, {conversation: {
                            volunteer:{}, task_user: {}  }}, :ok
        else
          json_response "Error finding or creating conversation", false, {}, :unprocessable_entity
        end
      end
    else
      json_response "Not fount task with this id", false, {}, :not_found
    end
  end


  def index
    if current_user.present?
      if params["task_id"].present?
       if params["conversation_id"].present?
           if Conversation.find(params["conversation_id"]).task_owner_id == current_user.id || Conversation.find(params["conversation_id"]).volunteer_id == current_user.id
           json_response "Messages in this conversation", true, { task: params["task_id"], messages: Message.where(conversation_id: params["conversation_id"], task_id: params["task_id"])}, :ok
         else
           json_response "You are not allowed to view this conversation", false, {}, :not_found
         end
       elsif Task.find(params["task_id"]).user_id == current_user.id
           json_response "Conversations for this task", true, {conversations: Conversation.where(task_id: params["task_id"]).joins("JOIN users ON volunteer_id = users.id").select('users.first_name, users.last_name, conversations.task_id, conversations.id')}, :ok
       elsif Conversation.find(params["task_id"]).volunteer_id == current_user.id
           json_response "Conversations for this task", true, {conversations: Conversation.where(task_id: params["task_id"]).joins("JOIN users ON task_owner_id = users.id").select('users.first_name, users.last_name, conversations.task_id, conversations.id')}, :ok
       else
         puts Task.find(params['task_id']).to_json
         json_response "You are not the owner of this task", false, {}, :not_found
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
end

