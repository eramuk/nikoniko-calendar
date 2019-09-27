class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "[#{Settings.app_name}] Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "[#{Settings.app_name}] Password reset"
  end
end
