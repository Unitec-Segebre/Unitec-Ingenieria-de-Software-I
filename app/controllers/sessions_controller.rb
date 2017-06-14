class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]

  def new
    redirect_to projects_path if current_user
  end

  def create
    username = params[:session][:username]
    password = params[:session][:password]

    @user = User.find_by_username(username)
    if @user && @user.authenticate(password)
      login(@user)
    else
      redirect_to login_path, flash: { error: 'Email o Password incorrecto' }
    end
  end

  def destroy
    logout
  end
end
