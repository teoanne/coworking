class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save(user_params)
      session[:user_id] = @user.id
      flash[:notice] = "Your profile was created"
      redirect_to root_path
    else
      flash[:error] = "There was an error was creating your profile"
      render :new
    end
  end

  def edit
    
  end

  def update
    @user = User.update(user_params)

    if@user.update
      flash[:notice] = "You have updated your profile"
      redirect_to user_path(user)
    else
      flash[:notice] = "There was an error while updating your profile"
      render :new
    end
  end

  def show
    
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :password, :username, :country, :email)
  end

  def set_user
    @user = User.find_by(params[:id])
  end

end