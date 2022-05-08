class Attendance < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # アソシエーション
  belongs_to :answer
  belongs_to :possible_date
  belongs_to :guest
end
