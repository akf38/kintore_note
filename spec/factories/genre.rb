FactoryBot.define do
  factory :genre do
    name { Faker::Lorem.characters(number:50) }
  end
end