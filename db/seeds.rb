# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'aaa',
            email: 'aaa@aaa.com',
            tall: 175,
            weight: 78,
            body_fat_percentage: 15,
            password: 'aaaaaa',
            password_confirmation: 'aaaaaa')

30.times do |number|
  UserInfo.create!(user_id: 1,
                weight: rand(50..90),
                body_fat_percentage: rand(6..35),
                created_at: "2021-#{rand(1..2)}-#{rand(1..28)} 04:39:22")
end

Record.create!(user_id: 1)
                
Genre.create!(name: 'バーベル')#1
Genre.create!(name: 'ダンベル')#2
Genre.create!(name: 'マシン')#3
Genre.create!(name: '自重')#4

Part.create!(name: '胸')#1
Part.create!(name: '背中')#2
Part.create!(name: '肩')#3
Part.create!(name: '上腕三頭筋')#4
Part.create!(name: '上腕二頭筋')#5
Part.create!(name: '腹筋')#6
Part.create!(name: '足')#7

Training.create!(name: 'ベンチプレス', genre_id: 1, part_id: 1)
Training.create!(name: 'インクラインベンチプレス', genre_id: 1, part_id: 1)
Training.create!(name: 'デクラインベンチプレス', genre_id: 1, part_id: 1)
Training.create!(name: 'ベントアームプルオーバー', genre_id: 1, part_id: 1)

Training.create!(name: 'ダンベルフライ', genre_id: 2, part_id: 1)
Training.create!(name: 'インクラインダンベルベンチプレス', genre_id: 2, part_id: 1)
Training.create!(name: 'ダンベルベンチプレス', genre_id: 2, part_id: 1)
Training.create!(name: 'ダンベルプルオーバー', genre_id: 2, part_id: 1)

TrainingRecord.create!(record_id: 1, training_id: 1, weight: 80, rep: 7, set: 3)
TrainingRecord.create!(record_id: 1, training_id: 2, weight: 80, rep: 7, set: 3)
TrainingRecord.create!(record_id: 1, training_id: 3, weight: 80, rep: 7, set: 3)