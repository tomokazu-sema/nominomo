class ApplicationController < ActionController::Base
  include ApplicationHelper
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
  def set_event_cookie(key)
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

  # 以下各コントローラ共通処理
  ### @eventを設定(paramsの都合上event_controllerでは使えないため注意)
  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end

  ### 主催者でない場合に開催日調整ページへ遷移させる
  def move_to_event_show
    redirect_to event_path(@event) unless host_user?(@event)
  end

  ### turbo-frameからのリクエスト出ない場合に開催日調整ページへ遷移させる
  ### (URL直打ち対策、GETでリクエストするアクションのみに適用)
  def move_to_event_show_noturbo
    redirect_to event_path(@event) unless turbo_frame_request?
  end
end
