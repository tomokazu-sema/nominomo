class Question < ApplicationRecord
  # バリデーション
  validates :title, presence: true

  # アソシエーション
  belongs_to :event
end
