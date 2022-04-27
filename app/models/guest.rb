class Guest < ApplicationRecord
  # バリデーション
  validates :name, presence: true

  # アソシエーション
  belongs_to :event
  has_many   :attendances, dependent: :destroy
end
