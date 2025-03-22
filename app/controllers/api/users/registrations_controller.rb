module Api
  module Users
    class RegistrationsController < Devise::RegistrationsController
      include Devise::Controllers::Helpers
      skip_before_action :authenticate_user!, only: [:create]
      respond_to :json

      private
      
      def set_flash_message!(*args)
        # Do nothing (prevents Devise from trying to set flash messages)
      end

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def respond_with(resource, _opts = {})
        if resource.persisted?
          render json: { user: resource, token: resource.authentication_token }, status: :created
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
