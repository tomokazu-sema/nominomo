class NoticesController < ApplicationController
  before_action :set_event
  before_action :set_notice, only: %i[edit update]

  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new(notice_params)
    respond_to do |format|
      if @notice.save
        format.html { redirect_to event_path(@event) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @notice.update(notice_params)
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

  def set_notice
    @notice = Notice.find(params[:id])
  end

  def notice_params
    params.require(:notice).permit(:message).merge(event_id: @event.id)
  end
end
