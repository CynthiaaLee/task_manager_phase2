module Api
  class UsersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:create, :sign_in]

    # POST /api/users (Sign Up)
    def create
      user = User.new(user_params)
      if user.save
        render json: { user: user, token: user.authentication_token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # POST /api/users/sign_in (Login)
    def sign_in
      user = User.find_by(email: params[:email])

      if user&.valid_password?(params[:password])
        render json: { user: user, token: user.authentication_token }, status: :ok
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end

    # POST /api/users/update_name (Update User Name)
    def update_name
      if current_user.update(name: params[:name])
        render json: { user: current_user, message: "Name updated successfully" }, status: :ok
      else
        render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
