class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper :all

  helper_method :current_user
  before_action :authenticate

  def login(user)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    reset_session
    redirect_to login_path
  end

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    redirect_to login_path unless current_user
  end
end
