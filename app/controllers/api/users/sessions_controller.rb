module Api
  module Users
    class SessionsController < Devise::SessionsController
      include Devise::Controllers::Helpers
      skip_before_action :verify_signed_out_user, only: [:destroy]
      skip_before_action :require_no_authentication, only: [:create]
      skip_before_action :authenticate_user!, only: [:create]
      respond_to :json

      def create
        email = params.dig(:user, :email) || params.dig(:session, :email)
        password = params.dig(:user, :password) || params.dig(:session, :password)

        if email.blank? || password.blank?
          return render json: { error: "Email and password are required" }, status: :unprocessable_entity
        end

        user = User.find_by(email: email)

        if user&.valid_password?(password)
          user.update(authentication_token: SecureRandom.hex(20))
          render json: { user: user, token: user.authentication_token }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      private

      def respond_with(resource, _opts = {})
        if resource.persisted?
          render json: { user: resource, token: resource.authentication_token }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      def respond_to_on_destroy
        if current_user
          current_user.update(authentication_token: nil)
          render json: { message: "User successfully logged out" }, status: :ok
        else
          render json: { error: "User not logged in" }, status: :unauthorized
        end
      end
      
    end
  end
end
