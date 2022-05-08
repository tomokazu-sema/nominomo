class PossibleDatesController < ApplicationController
  before_action :set_event

  def new
    @possible_date = PossibleDate.new
  end

  def create
    @possible_date = PossibleDate.new(possible_date_params)
    if @possible_date.save
      respond_to do |format|
        format.html { redirect_to event_path(@event) }
      end
    end
  end

  def destroy
    possible_date = PossibleDate.find(params[:id])
    possible_date.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@event) }
    end
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end

  def possible_date_params
    params.require(:possible_date).permit(:datetime).merge(event_id: Event.find_by(uid: params[:event_id]).id)
  end
end
