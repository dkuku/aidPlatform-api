class Api::V1::TasksController < ApplicationController
    before_action :load_task, only: [:show, :update, :destroy]
    before_action :authenticate_with_token!, only: [:create, :show, :update, :destroy]
    before_action :tasks_by_bounds, only: [:within]
    def index
        @tasks = Task.where(done: 0)
        json_response "Index tasks successfully", true, {tasks: @tasks}, :ok
    end

#    def show
#        if current_user.present?
#           json_response "Show task successfully", true, {
#            task: @task, 
#            conversations: @task.conversations.where(volunteer_id: current_user.id).or(@task.conversations.where(task_owner: current_user.id)).includes([:task_owner, :volunteer]).as_json(only: [:id, :task_id], methods: [:task_owner_name, :volunteer_name])
#            messages: @task.messages.where(volunteer_id: current_user.id).or(@task.messages.where(task_owner_id: current_user.id)),
#        }, :ok
#        else
#           json_response "Show task successfully", true, {task: @task}, :ok
#        end
#    end
    def show
        if current_user.present? 
            if current_user.id == @task.user_id
                json_response "Show task successfully", true, {
                    task: @task, 
                    conversations: @task.conversations.includes([:task_owner, :volunteer]).as_json(only: [:id, :task_id], methods: [:task_owner_name, :volunteer_name]),
                    messages: Message.where(task_id: @task.id), }, :ok
            #    @task.as_json(:include => { :conversations => {
            #        :include => { :messages => {
            #                        :only => [:body, :owner, :read] } },
            #        :only => :id, methods: [:volunteer_name] }} ), :ok
            else 
           json_response "Show task successfully", true, {
            task: @task, 
            conversations: @task.conversations.where(volunteer_id: current_user.id).includes([:task_owner, :volunteer]).as_json(only: [:id, :task_id], methods: [:task_owner_name, :volunteer_name]),
            messages: @task.messages.where(volunteer_id: current_user.id).or(@task.messages.where(task_owner_id: current_user.id)),
        }, :ok

            end
        else
           json_response "Show task successfully", true, {task: @task}, :ok
        end
    end

    def create
        task = Task.new task_params
        task.user_id = current_user.id
        if task.save
            json_response "Created task successfully", true, {task: task}, :ok
        else
            puts task.errors.full_messages.first
            json_response task.errors.full_messages.first, false, {}, :unprocessable_entity
        end
    end

    def update
        if correct_user @task.user
            if @task.update task_params
                json_response "Update task successfully", true, {task: @task}, :ok
            else
                json_response "Update task failed", false, {}, :unprocessable_entity
            end
        else
            json_response "You dont have permission to do this", false, {}, :unauthorized
        end

    end

    def destroy
        if correct_user @task.user
            if @task.destroy
                json_response "Deleted task successfully", true, {task: @task}, :ok
            else
                json_response "Deleted task failed", false, {}, :unprocessable_entity
            end
        else
            json_response "You dont have permission to do this", false, {}, :unauthorized
        end

    end
    def within
        json_response "Show task successfully", true, {tasks: @task}, :ok
    end

    private

    def tasks_by_bounds
        box = [task_params[:south], task_params[:west],task_params[:north], task_params[:east]]
        @task = Task.where(done: 0).within_bounding_box(box)
        unless @task.present?
            json_response "Cannot find task", false, {}, :not_found
        end
    end

    def load_task
        @task = Task.find_by id: params[:id]
        unless @task.present?
            json_response "Cannot find task", false, {}, :not_found
        end
    end

    def task_params
        params.require(:task).permit :title, :description, :lat, :lng, :task_type, :done, :south, :east, :north, :west
    end
end
