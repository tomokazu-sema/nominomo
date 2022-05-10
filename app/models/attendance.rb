class Attendance < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # バリデーション
  validates :answer_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 4 } 

  # アソシエーション
  belongs_to :answer
  belongs_to :possible_date
  belongs_to :guest
end
