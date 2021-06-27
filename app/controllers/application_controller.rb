class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def after_sign_up_path_for(resource)                    #新規登録した後に遷移する先
    users_path
  end

  def after_sign_in_path_for(resource)                    #ログインした後に遷移する先
    users_path
  end

  def configure_permitted_parameters                      #ログインする際の入力項目
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana,:email])
  end
end
