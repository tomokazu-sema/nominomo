FactoryBot.define do
  factory :attendance do
    answer_id { Faker::Number.between(from: 1, to: 4) }
    association :possible_date
    association :guest
  end
end
