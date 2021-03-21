FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    tall { rand(150..200) }
    weight { rand(30..300) }
    body_fat_percentage { rand(1..99) }
    start_date { rand(1900..2020)-rand(1..12)-rand(1..25) }
    is_deleted { "false" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
