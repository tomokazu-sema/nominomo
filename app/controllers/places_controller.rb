class PlacesController < ApplicationController
  def create
    place = Place.new(place_params)
    messages = if place.save
                 []
               else
                 place.errors.full_messages
               end
    render json: { model: place, messages: }
  end

  def update
    place = Place.find(params[:id])
    messages = if place.update(place_params)
                 []
               else
                 place.errors.full_messages
               end
    render json: { model: place, messages: }
  end

  private

  def place_params
    params.require(:place).permit(:place, :url,
                                  :comment).merge(event_id: Event.find_by(uid: params[:event_id]).id)
  end
end
