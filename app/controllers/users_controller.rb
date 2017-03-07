class UsersController < ApplicationController
  def index
    @users = User.all
    @count = 0
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(edit_params)
    if @user.save(validate: false)
      flash[:notice] = 'Modificado exitosamente'
      redirect_to @user
    else 
      puts @user.errors.full_messages
        flash[:alert] = "Un error ha ocurrido al modificar el usuario"
      redirect_to @user
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Creado exitosamente'
      redirect_to users_path
    else
      flash[:alert] = "Un error ha ocurrido al crear el usuario"
      render :new
    end
  end

  protected
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :middle_name, :last_name)
    end
    def edit_params
      params.require(:user).permit(:first_name, :middle_name, :last_name)
    end
end
