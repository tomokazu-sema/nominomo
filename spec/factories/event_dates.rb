FactoryBot.define do
  factory :event_date do
    association :event
    association :possible_date
  end
end
