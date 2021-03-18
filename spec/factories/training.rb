FactoryBot.define do
  factory :training do
    name { Faker::Lorem.characters(number:50) }
  end
end