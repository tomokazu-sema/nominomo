class PaymentManagement < ApplicationRecord
  # アソシエーション
  belongs_to :event
  has_many   :payments, dependent: :destroy
end
