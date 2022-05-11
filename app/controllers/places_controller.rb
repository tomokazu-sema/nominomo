class PlacesController < ApplicationController
  before_action :set_event
  before_action :set_place, only: %i[edit update]

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    respond_to do |format|
      if @place.save
        format.html { redirect_to event_path(@event) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to event_path(@event) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:place, :url, :comment).merge(event_id: @event.id)
  end
end
