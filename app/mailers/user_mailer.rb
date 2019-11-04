class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: I18n.t("acc_activation")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: I18n.t("pass_reset")
  end
end
