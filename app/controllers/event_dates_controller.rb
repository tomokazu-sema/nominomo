class EventDatesController < ApplicationController
  before_action :set_event

  def create
    @event_date = EventDate.new(event_id: @event.id, possible_date_id: params[:possible_date_id])
    respond_to do |format|
      format.html { redirect_to event_path(@event) } if @event_date.save
    end
  end

  def destroy
    event_date = EventDate.find(params[:id])
    event_date.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@event) }
    end
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end
end
