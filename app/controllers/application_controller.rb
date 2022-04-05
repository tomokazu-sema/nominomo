class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_parameters, if: :devise_controller?

  private

  # userモデルで:nameを受け取れるようにする
  ### ログイン
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  ### 編集 
  def configure_account_update_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
