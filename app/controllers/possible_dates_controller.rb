class PossibleDatesController < ApplicationController
  def create
    event = Event.find_by(uid: params[:event_id])
    possible_date = PossibleDate.new(event_id: event.id, datetime: params[:datetime])
    messages = if possible_date.save
                 []
               else
                 possible_date.errors.full_messages
               end
    render json: { model: possible_date, messages: }
  end
end
