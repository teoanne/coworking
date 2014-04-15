class SessionsController < ApplicationController

  def new
    user = User.new
  end

  def create
    user = User.find_by(username: params[:username])

    if user #and user.authenticate(params :password)
      session[:user_id] = user.id
      flash[:notice] = "You have logged in successfully"
      redirect_to root_path
    else
      flash[:error] = "There was something wrong with your username or password. Try logging in again or please register below"
      redirect_to register_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:error] = "You have logged out successfully"
    redirect_to root_path
  end


end