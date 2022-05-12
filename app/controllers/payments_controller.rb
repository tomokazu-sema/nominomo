class PaymentsController < ApplicationController
  before_action :set_event
  before_action :set_guest, only: %i[new edit]
  before_action :set_payment_management, only: %i[new edit]
  before_action :set_payment, only: %i[edit update]

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    respond_to do |format|
      if @payment.save
        format.html { redirect_to event_path(@event) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
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

  def set_guest
    @guest = Guest.find(params[:guest_id])
  end

  def set_payment_management
    @payment_management = PaymentManagement.find(params[:payment_management_id])
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:guest_id, :price, :status_id).merge(payment_management_id: params[:payment_management_id])
  end
end
