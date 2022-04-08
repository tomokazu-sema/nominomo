class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.valid?
      @event.save
      Host.create(event_id: @event.id)
      redirect_to "/events/#{@event.uid}/hosts/#{@event.host.uid}/info"
    else
      render :new, status: :unprocessable_entity 
    end
  end

  private

  def event_params
    form_params = params.require(:event).permit(:title, :password)
    form_params = form_params.merge(user_id: current_user.id) if user_signed_in?
    return form_params
  end
end
