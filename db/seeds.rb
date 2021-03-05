# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

30.times do |number|
  UserInfo.create!(user_id: 1,
                weight: rand(50..90),
                body_fat_percentage: rand(6..35),
                created_at: "2021-#{rand(1..2)}-#{rand(1..28)} 04:39:22")
end