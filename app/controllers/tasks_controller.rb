class TasksController < ApplicationController
    before_action :require_login
  
    def new
      @task = Task.new  # 👈 This ensures @task is available in the form
    end

    def index
      @tasks = Task.includes(:user, :labels).order(created_at: :desc)
    end

    def create
      @task = current_user.tasks.build(task_params)
    
      if @task.save
        redirect_to tasks_path, notice: "Task created successfully!"
      else
        puts @task.errors.full_messages  # 🔍 Debugging: Print errors to the console
        flash.now[:alert] = "Failed to create task: " + @task.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
      end
    end
    

    def edit
        @task = Task.find_by(id: params[:id])
        if @task.nil?
          redirect_to tasks_path, alert: "Task does not exist!"
        elsif @task.user != current_user
          redirect_to tasks_path, alert: "You do not have permission to edit this task!"
        end
      end

      def update
        @task = Task.find_by(id: params[:id])
      
        if @task.nil?
          redirect_to tasks_path, alert: "Task does not exist!"
        elsif @task.user != current_user
          redirect_to tasks_path, alert: "You do not have permission to update this task!"
        elsif @task.update(task_params)
          puts "✅ Task updated successfully!"
          redirect_to @task, notice: "Task updated successfully!"
        else
          puts "❌ Task update failed! Errors: #{@task.errors.full_messages}"
          render :edit, status: :unprocessable_entity
        end
      end
      
      def show
        @task = Task.find_by(id: params[:id])
        
        if @task.nil?
          redirect_to tasks_path, alert: "Task does not exist!"
        else
          # Allow all users to view the task
        end
      end

      def destroy
        @task = Task.find_by(id: params[:id])
      
        if @task.nil?
          redirect_to tasks_path, alert: "Task does not exist!"
        elsif @task.user != current_user
          redirect_to tasks_path, alert: "You do not have permission to delete this task!"
        else
          @task.destroy
          redirect_to tasks_path, notice: "Task deleted successfully!"
        end
      end
      
      
    private
  
    def task_params
      params.require(:task).permit(:title, :description, :status, :due_date, label_ids: [])
    end
  end
  