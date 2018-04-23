class Api::V1::TasksController < ApplicationController
    before_action :load_task, only: [:show, :update, :destroy]
    before_action :authenticate_with_token!, only: [:create, :update, :destroy]
    def index
        @tasks = Task.all
        json_response "Index tasks successfully", true, {tasks: @tasks}, :ok
    end

    def show
        json_response "Show task successfully", true, {task: @task}, :ok
    end

    def create
        task = Task.new task_params
        task.user_id = current_user.id
        if task.save
            json_response "Created task successfully", true, {task: task}, :ok
        else
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

    private

    def load_task
        @task = Task.find_by id: params[:id]
        unless @task.present?
            json_response "Cannot find task", false, {}, :not_found
        end
    end

    def task_params
        params.require(:task).permit :title, :description, :lat, :lng, :task_type
    end
end
