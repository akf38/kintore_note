FactoryBot.define do
  factory :user_info do
    weight { rand(30..300) }
    body_fat_percentage { rand(1..99) }
  end
end
