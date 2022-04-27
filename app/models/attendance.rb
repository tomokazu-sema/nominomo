class Attendance < ApplicationRecord
  # アソシエーション
  belongs_to :possible_date
  belongs_to :guest
end
