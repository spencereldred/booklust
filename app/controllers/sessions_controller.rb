class SessionsController < ApplicationController
  before_filter :logged_in, only: :new

  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to booklusts_path, notice: "Welcome #{user.name}, you are signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You are signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end
