class PossibleDate < ApplicationRecord
  # バリデーション
  validates :date, presence: true

  # アソシエーション
  belongs_to :event
  has_one    :event_date
  has_many   :attendances, dependent: :destroy
end
