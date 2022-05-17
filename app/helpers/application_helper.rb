module ApplicationHelper
  # 引数eventの引数keyに該当するcookieを持っているか判定する
  def has_event_cookie?(key, event)
    cookies.signed[key] && cookies.signed[key].include?(event.id)
  end

  # 引数eventを作成したユーザーか判定する
  def user_created_event?(event)
    user_signed_in? && event.user && current_user.id == event.user_id
  end

  # 引数eventの主催者であるか判定する
  def host_user?(event)
    has_event_cookie?(:host, event) || user_created_event?(event)
  end
end
