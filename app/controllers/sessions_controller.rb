class SessionsController < ApplicationController
    def new
        @user = User.new
    end
  
    def create
      user = User.find_by(email: params[:email])  # Corrected parameter structure
    
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to tasks_path, notice: "Login successful!"
      else
        flash.now[:alert] = "Invalid email or password. Please try again."
        render :new, status: :unprocessable_entity
      end
    end
    
    
  
    def destroy
      session[:user_id] = nil
      redirect_to login_path, notice: "Logged out successfully."
    end
  end
  