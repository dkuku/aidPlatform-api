class Api::V1::ConversationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :index, :destroy]

  def create
    sender_id = current_user.id
    #check if conversation exist if yes load it
    if Conversation.between(sender_id, conv_params[:task_id]).present?
      conversation = Conversation.between(sender_id, conv_params[:task_id].first)
      json_response "Conversation found", true, {conversation: conversation, sender: Message.where(user_id: current_user.id), recipient: Message.where(task_id: conv_params[:task_id]) }, :ok
      #if not check if user dont volunteer on his own task
    elsif Task.where(user_id: current_user.id).first.user_id == current_user.id
        json_response "You can't Volunteer on your own request", false, {}, :unprocessable_entity
    else
      #create conversation
      conversation = Conversation.new conv_params
      conversation.sender_id = current_user.id
      if conversation.save
        json_response "Conversation created", true, {conversation: conversation, sender:{}, recipient: {}  }, :ok
      else
        json_response "Error finding or creating conversation", false, {}, :unprocessable_entity
      end
    end
  end
end


  def index
    puts params
    @type=params[:type]
    #we can have to routes /task/:id/conversation - showing index for 1 task
    if @type == 'task'
      @conversation_sender = Conversation.where(sender_id: current_user.id, task_id: params[:task_id])
      @conversation_recipient = Conversation.joins(:task).where(tasks: {user_id: current_user.id, id: params[:task_id]})
    else
      #/conversation showing all tasks
      @conversation_sender = Conversation.where(sender_id: current_user.id)
      @conversation_recipient = Conversation.joins(:task).where(tasks: {user_id: current_user.id})
    end
    json_response "Users conversations", true, {sender: @conversation_sender, recipient: @conversation_recipient  }, :ok
  end

  private
  def conv_params
      params.require(:conversation).permit :task_id
  end
end

