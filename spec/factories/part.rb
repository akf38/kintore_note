FactoryBot.define do
  factory :part do
    name { Faker::Lorem.characters(number:50) }
  end
end