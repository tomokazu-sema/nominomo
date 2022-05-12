class Payment < ApplicationRecord
  # アソシエーション
  belongs_to :guest
  belongs_to :payment_management
end
