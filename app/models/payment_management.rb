class PaymentManagement < ApplicationRecord
  # アソシエーション
  belongs_to :event
  has_many   :payments, dependent: :destroy

  # 会費管理用 引数guestに対応するpaymentモデルを返す
  def payment(guest)
    payments.each do |payment|
      return payment if payment.guest_id == guest.id
    end
    nil
  end
end
