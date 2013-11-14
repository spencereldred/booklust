class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    # sends user back to login page if current_user is nil
    redirect_to root_path if !current_user
  end

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
