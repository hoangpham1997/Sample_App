class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: I18n.t("acc_activation")
  end

  def password_reset
    @greeting = t "hi"

    mail to: "to@example.org"
  end
end
