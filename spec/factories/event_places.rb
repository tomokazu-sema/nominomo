FactoryBot.define do
  factory :event_place do
    place   { Faker::Restaurant.name }
    url     { Faker::Internet.url }
    comment { Faker::Restaurant.description }
    association :event
  end
end
