class CommentsController < ApplicationController
    before_action :require_login
  
    def create
      @task = Task.find(params[:task_id])
      @comment = @task.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        redirect_to @task, notice: "Comment added successfully!"
      else
        redirect_to @task, alert: "Comment cannot be blank."
      end
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      if @comment.user == current_user
        @comment.destroy
        redirect_to @comment.task, notice: "Comment deleted."
      else
        redirect_to @comment.task, alert: "You can only delete your own comments."
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  
    def require_login
      unless current_user
        redirect_to login_path, alert: "You must be logged in to comment."
      end
    end
  end
  