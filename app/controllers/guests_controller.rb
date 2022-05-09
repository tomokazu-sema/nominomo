class GuestsController < ApplicationController
  before_action :set_event
  before_action :set_possible_dates, only: [:new, :edit]
  before_action :set_guest, only: [:edit, :update]

  def new
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

  def edit
    @guest = Guest.find(params[:id])
    @attendances = @guest.attendances
  end

  def update
    if @guest.update(guest_params)
      respond_to do |format|
        format.html { redirect_to event_path(@event) }
      end
    end
  end

  def destroy
    guest = Guest.find(params[:id])
    guest.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@event) }
    end
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end

  def set_possible_dates
    @possible_dates = @event.possible_dates.order(datetime: :ASC)
  end

  def set_guest
    @guest = Guest.find(params[:id])
  end

  def guest_params
    params.require(:guest).permit(:name, :comment, attendances_attributes:[:id, :possible_date_id, :answer_id]).merge(event_id: Event.find_by(uid: params[:event_id]).id)
  end
end
