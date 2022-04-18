class EventPlacesController < ApplicationController
  def create
    event_place = EventPlace.new(event_place_params)
    messages = if event_place.save
                 []
               else
                 event_place.errors.full_messages
               end
    render json: { model: event_place, messages: }
  end

  def update
    event_place = EventPlace.find(params[:id])
    messages = if event_place.update(event_place_params)
                 []
               else
                 event_place.errors.full_messages
               end
    render json: { model: event_place, messages: }
  end

  private

  def event_place_params
    params.require(:event_place).permit(:place, :url,
                                        :comment).merge(event_id: Event.find_by(uid: params[:event_id]).id)
  end
end