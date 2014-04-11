class SessionsController < ApplicationController

  def new
    user = User.new
  end

  def create
    user = User.find_by(username: [params :username])

    if user and user.authenticate(params :password)
      session[:user_id] = user.id
      flash[:notice] = "You have logged in successfully"
      redirect_to root_path
    else
      flash[:error] = "There was something wrong with your username or password"
      render :new
  end

  def destroy
    session[:user_id] = nil
    flash[:error] = "You have logged out successfully"
    redirect_to root_path
  end


end