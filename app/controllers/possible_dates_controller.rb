class PossibleDatesController < ApplicationController
  before_action :set_event
  before_action :set_possible_date, only: [:edit, :update]

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

  def edit
  end

  def update
    if @possible_date = @possible_date.update(possible_date_params)
      respond_to do |format|
        format.html { redirect_to event_path(@event) }
      end
    end
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end

  def set_possible_date
    @possible_date = PossibleDate.find(params[:id])
  end

  def possible_date_params
    params.require(:possible_date).permit(:datetime).merge(event_id: Event.find_by(uid: params[:event_id]).id)
  end
end
