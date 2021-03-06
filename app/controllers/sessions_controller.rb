class SessionsController < ApplicationController

  def new
    user = User.new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      if user.active?
        session[:user_id] = user.id
        flash[:notice] = "Welcome back #{user.full_name}"
        redirect_to home_path
      else
        session[:user_id] = user.id
        user.activate!
        flash[:danger] = "You have reactivated your account. Welcome back."
        redirect_to home_path
      end
    else
      flash[:error] = "There was something wrong with your username or password. Try logging in again or please register below"
      redirect_to register_path
    end
  end

  def delete
    session[:user_id] = nil
    redirect_to root_path
  end


end