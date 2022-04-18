class EventPlacesController < ApplicationController
  def create
    event_place = EventPlace.new(event_place_params)
    if event_place.save
      messages = []
    else
      messages = event_place.errors.full_messages
    end
    render json: { model: event_place, messages: messages }
  end

  def update
    event_place = EventPlace.find(params[:id])
    if event_place.update(event_place_params)
      messages = []
    else
      messages = event_place.errors.full_messages
    end
    render json: { model: event_place, messages: messages }
  end

  private

  def event_place_params
    params.require(:event_place).permit(:place, :url, :comment).merge(event_id: Event.find_by(uid: params[:event_id]).id)
  end
end
