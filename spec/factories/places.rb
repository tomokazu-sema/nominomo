FactoryBot.define do
  factory :place do
    place   { Faker::Restaurant.name }
    url     { Faker::Internet.url }
    comment { Faker::Restaurant.description }
    association :event
  end
end
