FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    tall { rand(150..200) }
    weight { rand(30..300) }
    body_fat_percentage { rand(1..99) }
    is_deleted { "false" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
