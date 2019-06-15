class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "[#{ENV['APP_NAME']}] Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "[#{ENV['APP_NAME']}] Password reset"
  end
end
