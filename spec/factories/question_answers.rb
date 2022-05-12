FactoryBot.define do
  factory :question_answer do
    answer { Faker::Lorem.sentence }
    association :guest
    association :question
  end
end
