class ResetPasswordsController < ApplicationController

  def show
    user = User.where(token: params[:id]).first
    if user
      @token = user.token
      render :show
    else
      redirect_to invalid_token_path 
    end
  end

  def create
    @user = User.where(token: params[:token]).first
    
    if @user
      @user.password = params[:password]
      @user.generate_token
      @user.save
      flash[:success] = "Your password was successfully changed. Please sign in."
      redirect_to login_path
    else
      redirect_to invalid_token_path
    end
  end

  
end