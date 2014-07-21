class ForgotPasswordsController < ApplicationController
  
  def create
    @user = User.find_by(email: params[:email])
    if @user
      AppMailer.send_forgot_password(@user).deliver
      redirect_to reset_confirmation_path
    else
      flash[:danger] = params[:email].blank? ? "Email field cannot be left blank." : "A user with that email could not be found. Please check your email or register as a user instead."
      render "forgot_passwords/new"
    end
  end

  def reset
  end


end