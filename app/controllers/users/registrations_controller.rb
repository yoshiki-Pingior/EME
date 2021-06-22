class Users::RegistrationsController < Devise::RegistrationsController
  def create
    #スーパークラス(devise)のcreateアクションを呼ぶ
    super
    #WelcomeMailerクラスのsend_when_signupメソッドを呼び、POSTから受け取ったuserのemailとnameを渡す
    WelcomeMailer.send_when_signup(current_user,params[:user][:email]).deliver_later
  end


end