class PossibleDatesController < ApplicationController
  def new
    @event = Event.find_by(uid: params[:event_id])
    @possible_date = PossibleDate.new
  end

  def create
    @event = Event.find_by(uid: params[:event_id])
    @possible_date = PossibleDate.new(possible_date_params)
    if @possible_date.save
      respond_to do |format|
        format.html { redirect_to @event }
      end
    end
  end

  private

  def possible_date_params
    params.require(:possible_date).permit(:datetime).merge(event_id: Event.find_by(uid: params[:event_id]).id)
  end
end
