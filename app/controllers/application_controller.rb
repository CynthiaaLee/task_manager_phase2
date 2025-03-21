# class ApplicationController < ActionController::Base
#   helper_method :current_user, :logged_in?

#   def current_user
#     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
#   end

#   def logged_in?
#     !!current_user
#   end

#   def require_login
#     unless logged_in?
#       redirect_to login_path, alert: "You must be logged in to access this page."
#     end
#   end
# end

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "You must be logged in."
    end
  end
end
