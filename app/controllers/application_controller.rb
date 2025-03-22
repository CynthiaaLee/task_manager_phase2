class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def current_user
    @current_user ||= authenticate_token
  end

  private

  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized - Invalid Token' }, status: :unauthorized
    end
  end

  def authenticate_token
    token = request.headers['Authorization']&.split(' ')&.last
    User.find_by(authentication_token: token)
  end
end
