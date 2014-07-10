class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:show]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save(user_params)
      session[:user_id] = @user.id
      flash[:notice] = "Welcome on board #{@user.full_name}! Glad to have you with us."
      redirect_to home_path
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

  def deactivate
    @user = current_user
    @user.deactivate!
    flash[:danger] = "Your account has been deleted. If you wish to rejoin, just sign in again with your previous username and password."
    redirect_to logout_path
  end

  def reactivate
    @user.activate!
    flash[:success] = "You have rejoined Coworkr. Welcome back #{@user.name}!"
    redirect_to home_path
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :password, :username, :country, :email)
  end

  def require_same_user
    access_denied unless logged_in? && (@user == current_user || current_user.admin?)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

end