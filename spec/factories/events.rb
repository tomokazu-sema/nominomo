FactoryBot.define do
  factory :event do
    uid      { Faker::Lorem.characters(number: 32) }
    title    { Faker::Team.name }
    password { Faker::Lorem.characters(number: 6) }
    association :user
  end
end
