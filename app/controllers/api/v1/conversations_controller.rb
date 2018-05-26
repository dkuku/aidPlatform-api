class Api::V1::ConversationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :index, :destroy]
  before_action :load_task, only: [:create, :show]

  def show
    volunteer_id = current_user.id
    task_user_id = task.user_id
    #check if conversation exist if yes load it
    if Conversation.between(volunteer_id, @task.id).present?
      conversation = Conversation.between(volunteer_id, @task.id).first
      messages_response(conversation.id)
    else
      #if not check if user dont volunteer on his own task
      json_response "Error finding conversation", false, {}, :not_found
    end
  end 

  def create
    volunteer_id = current_user.id
    if Conversation.between(volunteer_id, @task.id).present?
      conversation = Conversation.between(volunteer_id, @task.id).first
      json_response "You can now contact the task Creator", true, {
        task: Task.find(conversation.id),
        conversation: conversation,
        messages: conversation.messages,
        #conversations: @task.conversations.where(task_owner_id: current_user.id).or(@task.conversations.where(volunteer_id: current_user.id)).includes([:task_owner, :volunteer]).as_json(only: [:id], methods: [:task_owner_name, :volunteer_name])
        }, :ok
    elsif @task.user_id == volunteer_id
      json_response "You can't volunteer on your own request", false, {}, :unprocessable_entity
    elsif @task.fulfilment_counter > 4 || @task.done>0
      json_response "This task has too many volunteers already", true, {}, :gone
     #create conversation
    else
      conversation = Conversation.new conv_params
      conversation.volunteer_id = volunteer_id
      conversation.task_owner_id = @task.user_id
      if conversation.save
        @task.increment!(:fulfilment_counter)
      json_response "You can now contact the task Creator", true, {
        task: @task,
        conversation: conversation,
        messages: conversation.messages,
        #conversations: @task.conversations.where(task_owner_id: current_user.id).or(@task.conversations.where(volunteer_id: current_user.id)).includes([:task_owner, :volunteer]).as_json(only: [:id], methods: [:task_owner_name, :volunteer_name])
        }, :ok
      else
        json_response "Error finding or creating conversation", false, {}, :unprocessable_entity
      end
    end
  end

  def destroy
    if current_user.present?
      if params["conversation_id"].present?
        if Conversation.find(params["conversation_id"]).task_owner_id == current_user.id || Conversation.find(params["conversation_id"]).volunteer_id == current_user.id
          task = Task.find(Conversation.find(params["conversation_id"]).task_id)
          task.update_attributes(done: current_user.id)
          json_response "Task marked as done", true, {task: task}, :ok
        else
         json_response "You are not allowed to change this task", false, {}, :unauthorized
        end
      end
    else
      json_response "You need to log in to change this task", false, {}, :unauthenticated
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
      json_response "You Need to log in to view conversations", false, {}, :unauthenticated
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

def load_task
  @task = Task.find_by id: conv_params[:task_id]
  unless @task.present?
      json_response "Cannot find task", false, {}, :not_found
  end
end
