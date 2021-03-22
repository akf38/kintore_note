FactoryBot.define do
  factory :record do
    comment { Faker::Lorem.characters(number: 50) }
  end
end
