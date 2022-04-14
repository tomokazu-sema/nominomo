module EventsHelper
  def has_event_cookie?(key, event)
    cookies.signed[key] && cookies.signed[key].include?(event.id)
  end

  def user_created_event?(event)
    user_signed_in? && event.user && current_user.id == event.user_id
  end

  def host_user?(event)
    has_event_cookie?(:host, event) || user_created_event?(event)
  end
end
