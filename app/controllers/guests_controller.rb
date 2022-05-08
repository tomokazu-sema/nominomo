class GuestsController < ApplicationController
  before_action :set_event

  def new
    @possible_dates = @event.possible_dates.order(datetime: :ASC)
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    if @guest.save
      respond_to do |format|
        format.html { redirect_to event_path(@event) }
      end
    end
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end

  def guest_params
    params.require(:guest).permit(:name, :comment).merge(event_id: Event.find_by(uid: params[:event_id]).id)
  end
end
