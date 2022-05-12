class PaymentManagementsController < ApplicationController
  before_action :set_event

  def create
    payment_management = PaymentManagement.new(event_id: @event.id)
    payment_management.save
    respond_to do |format|
      format.html { redirect_to event_path(@event) }
    end
  end

  def destroy
    payment_management = PaymentManagement.find(params[:id])
    payment_management.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@event), status: :see_other }
    end
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end
end
