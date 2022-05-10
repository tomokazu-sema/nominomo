class GuestsController < ApplicationController
  before_action :set_event
  before_action :set_possible_dates, only: %i[new edit]
  before_action :set_guest, only: %i[edit update]

  def new
    @guest = Guest.new
    set_attendances
  end

  def create
    @guest = Guest.new(guest_params)
    respond_to do |format|
      if @guest.save
        format.html { redirect_to event_path(@event) }
      else
        set_possible_dates
        set_attendances
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @guest = Guest.find(params[:id])
    set_attendances
  end

  def update
    respond_to do |format|
      if @guest.update(guest_params)
        format.html { redirect_to event_path(@event) }
      else
        set_possible_dates
        set_attendances
        format.html { render :edit, status: :unprocessable_entity }
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

  def set_attendances
    @attendances = @guest.attendances
  end

  def guest_params
    params.require(:guest).permit(:name, :comment,
                                  attendances_attributes: %i[id possible_date_id answer_id]).merge(event_id: Event.find_by(uid: params[:event_id]).id)
  end
end
