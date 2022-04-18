class EventPlace < ApplicationRecord
  # バリデーション
  validates :place, presence: true

  # アソシエーション
  belongs_to :event
end
