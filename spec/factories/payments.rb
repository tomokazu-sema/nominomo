FactoryBot.define do
  factory :payment do
    price     { Faker::Number.between(from: 1000, to: 3000) }
    status_id { Faker::Number.between(from: 1, to: 2) }
    association :guest
    association :payment_management
  end
end
