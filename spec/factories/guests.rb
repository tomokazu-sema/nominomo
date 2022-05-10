FactoryBot.define do
  factory :guest do
    name    { Faker::Name.last_name }
    comment { Faker::Lorem.sentence }
    association :event
  end
end
