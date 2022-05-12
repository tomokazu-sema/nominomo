class QuestionAnswer < ApplicationRecord
  # アソシエーション
  belongs_to :guest
  belongs_to :question
end
