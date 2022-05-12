FactoryBot.define do
  factory :question do
    title   { Faker::Lorem.words }
    content { Faker::Lorem.sentence }
    association :event
  end
end
