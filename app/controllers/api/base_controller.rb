module Api
  class BaseController < ApplicationController
    before_action :authenticate_user!

    private

    def authenticate_user!
      token = request.headers['Authorization']&.split(' ')&.last
      @current_user ||= User.find_by(authentication_token: token)

      if @current_user
        sign_in @current_user, store: false
      else
        render json: { error: 'Unauthorized - Invalid Token' }, status: :unauthorized
      end
    end
  end
end
