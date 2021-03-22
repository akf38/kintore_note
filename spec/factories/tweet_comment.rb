FactoryBot.define do
  factory :tweet_comment do
    content { Faker::Lorem.characters(number: 100) }
  end
end
