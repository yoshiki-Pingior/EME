class WelcomeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_mailer.send_when_signup.subject
  #
  def send_when_signup(user, email)
    @user = params[:user]
    mail to: email, subject: "登録完了のお知らせ"
  end

end
