class UsersController < ApplicationController
    def new
      @user = User.new  # 👈 This ensures @user is not nil
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to tasks_path, notice: "Account created successfully."
      else
        flash.now[:alert] = @user.errors.full_messages.join(", ")
        render :new
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  