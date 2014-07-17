class AppMailer < ActionMailer::Base

  def send_forgot_password(user)
    @user = user
    mail to: user.email, from: "info@coworkr.com", subject: "Please reset your Coworkr password"
  end

end