class SessionsController < ApplicationController
  before_filter :logged_in, only: :new

  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to booklusts_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def failure
    redirect_to root_url
  end
end
