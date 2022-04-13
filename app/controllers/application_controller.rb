class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_parameters, if: :devise_controller?

  private

  # basic認証
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  # userモデルで:nameを受け取れるようにする
  ### ログイン
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  ### 編集
  def configure_account_update_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # cookieを渡す
  def set_cookie(key)
    # cookieを取得
    event_ids = cookies.signed[key]
    if event_ids
      # cookieを既に持っている場合
      # cookieから存在しないeventを取り除く
      ids = []
      event_ids.each do |id|
        ids << id if Event.find_by(id:)
      end
      # 作成したeventを加えたcookieを渡す
      ids << @event.id unless ids.include?(@event.id)
      cookies.signed[key] = { value: ids, expires: 1.year.from_now }
    else
      # cookieを持っていない場合
      # 作成したeventのcookieを渡す
      cookies.signed[key] = { value: [@event.id], expires: 1.year.from_now }
    end
  end
end
