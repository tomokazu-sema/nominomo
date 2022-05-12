class Payment < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # バリデーション
  validates :status_id, presence: true,
                        numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }

  # アソシエーション
  belongs_to :status
  belongs_to :guest
  belongs_to :payment_management
end
