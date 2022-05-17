class PossibleDatesController < ApplicationController
  before_action :set_event
  before_action :move_to_event_show
  before_action :move_to_event_show_noturbo, only: :new

  def new
    @possible_date = PossibleDate.new
  end

  def create
    @possible_date = PossibleDate.new(possible_date_params)
    respond_to do |format|
      if @possible_date.save
        format.html { redirect_to event_path(@event) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    possible_date = PossibleDate.find(params[:id])
    possible_date.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@event), status: :see_other }
    end
  end

  private

  def possible_date_params
    params.require(:possible_date).permit(:datetime).merge(event_id: @event.id)
  end
end
