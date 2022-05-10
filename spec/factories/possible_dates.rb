FactoryBot.define do
  factory :possible_date do
    datetime { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    association :event
  end
end
