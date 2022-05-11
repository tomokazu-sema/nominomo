FactoryBot.define do
  factory :notice do
    message { Faker::Lorem.sentence }
    association :event
  end
end
