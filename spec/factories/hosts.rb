FactoryBot.define do
  factory :host do
    uid      { Faker::Lorem.characters(number: 32) }
    association :event
  end
end
