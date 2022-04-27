class PossibleDate < ApplicationRecord
  # バリデーション
  validates :date, presence: true

  # アソシエーション
  belongs_to :event
end
