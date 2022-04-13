class HostsController < ApplicationController
  before_action :set_event
  before_action :set_host_cookie

  def info; end

  def show
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end

  def set_host_cookie
    set_cookie(:host)
  end
end
