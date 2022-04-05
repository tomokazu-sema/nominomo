FactoryBot.define do
  factory :user do
    uid                   { Faker::Lorem.characters(number: 16) }
    name                  { Faker::Team.name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6) }
    password_confirmation { password }
  end
end
