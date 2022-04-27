class Guest < ApplicationRecord
  # バリデーション
  validates :name, presence: true

  # アソシエーション
  belongs_to :event
end
