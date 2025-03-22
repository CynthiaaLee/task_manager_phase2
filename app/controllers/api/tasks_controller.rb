module Api
  class TasksController < BaseController
    before_action :authenticate_user!
    before_action :set_task, only: [:show, :update, :destroy]

    def index
      tasks = Task.includes(:labels, :user).order(created_at: :desc)  # ✅ Fetch all tasks
      render json: tasks, status: :ok
    end

    def show
      render json: @task, status: :ok
    end

    def create
      task = current_user.tasks.build(task_params)

      if task.save
        render json: task, status: :created
      else
        render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @task.update(task_params)
        render json: @task, status: :ok
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      if @task.user == current_user
        @task.destroy
        render json: { message: "Task deleted successfully" }, status: :ok  # ✅ Ensure message is returned
      else
        render json: { error: "You do not have permission to delete this task" }, status: :forbidden
      end
    end

    private

    def set_task
      @task = Task.find_by(id: params[:id])
      return render json: { error: "Task not found" }, status: :not_found unless @task
    end

    def task_params
      params.require(:task).permit(:title, :description, :status, :due_date, label_ids: [])
    end
  end
end
