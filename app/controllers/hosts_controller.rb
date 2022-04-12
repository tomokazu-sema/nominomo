class HostsController < ApplicationController
  before_action :set_event
  before_action :set_host_cookie

  def info
  end

  def show
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end

  def set_host_cookie
    # cookieを取得
    event_ids = cookies.signed[:host]
    if event_ids
      # cookieを既に持っている場合
      # cookieから存在しないeventを取り除く
      ids = []
      event_ids.each do |id|
        ids << id if Event.find_by(id: id) && id != @event.id
      end
      # 作成したeventを加えたcookieを渡す
      ids << @event.id
      cookies.signed[:host] = { value: ids, expires: 1.year.from_now }
    else
      # cookieを持っていない場合
      # 作成したeventのcookieを渡す
      cookies.signed[:host] = { value: [@event.id], expires: 1.year.from_now }
    end
  end
end
