class EventDate < ApplicationRecord
  # アソシエーション
  belongs_to :event
  belongs_to :possible_date
end
