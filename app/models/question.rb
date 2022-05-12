class Question < ApplicationRecord
  # バリデーション
  validates :title, presence: true

  # アソシエーション
  belongs_to :event
  has_many   :question_answers, dependent: :destroy
end
