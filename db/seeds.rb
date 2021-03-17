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
            start_date: "2016-02-01 15:00:00",
            password_confirmation: 'aaaaaa')

30.times do |number|
  UserInfo.create!(user_id: 1,
                weight: rand(50..90),
                body_fat_percentage: rand(6..35),
                created_at: "2021-#{rand(1..2)}-#{rand(1..28)} 04:39:22")
end

Record.create!(user_id: 1,
               start_time: "2021-2-9 04:39:22",
               created_at: "2021-2-9 04:39:22")
                
Genre.create!(name: 'バーベル')#1
Genre.create!(name: 'ダンベル')#2
Genre.create!(name: 'マシン')#3
Genre.create!(name: '自重')#4

Part.create!(name: '胸')#1
Part.create!(name: '背中')#2
Part.create!(name: '肩')#3
Part.create!(name: '腕')#4
Part.create!(name: '腹')#5
Part.create!(name: '脚')#6

Training.create!(name: 'ベンチプレス', genre_id: 1, part_id: 1)
Training.create!(name: 'ダンベルプレス', genre_id: 2, part_id: 1)
Training.create!(name: 'ダンベルフライ', genre_id: 2, part_id: 1)


Training.create!(name: 'ダンベルカール', genre_id: 2, part_id: 4)
Training.create!(name: 'ハンマーカール', genre_id: 2, part_id: 4)
Training.create!(name: 'キックバック', genre_id: 2, part_id: 4)
Training.create!(name: 'フレンチプレス', genre_id: 2, part_id: 4)

Training.create!(name: 'フロントレイズ', genre_id: 2, part_id: 3)
Training.create!(name: 'サイドレイズ', genre_id: 2, part_id: 3)
Training.create!(name: 'ダンベルリアレイズ', genre_id: 2, part_id: 3)

Training.create!(name: 'デッドリフト', genre_id: 1, part_id: 2)

Training.create!(name: 'クランチ', genre_id: 4, part_id: 5)
Training.create!(name: 'アブローラー', genre_id: 4, part_id: 5)

Training.create!(name: 'スクワット', genre_id: 1, part_id: 6)

Training.create!(name: 'チェストプレス', genre_id: 3, part_id: 1)
Training.create!(name: 'チェストフライ', genre_id: 3, part_id: 1)
Training.create!(name: 'ケーブルクロスオーバー', genre_id: 3, part_id: 1)

Training.create!(name: 'プリチャーカール', genre_id: 3, part_id: 4)
Training.create!(name: 'ケーブルプレスダウン', genre_id: 3, part_id: 4)
Training.create!(name: 'ディップス', genre_id: 3, part_id: 4)

Training.create!(name: 'ケーブルフロントレイズ', genre_id: 3, part_id: 3)
Training.create!(name: 'マシンショルダープレス', genre_id: 3, part_id: 3)
Training.create!(name: 'ケーブルリアレイズ', genre_id: 3, part_id: 3)

Training.create!(name: 'ラットプルダウン', genre_id: 3, part_id: 2)
Training.create!(name: 'シーテッドロー', genre_id: 3, part_id: 2)

Training.create!(name: 'アブドミナル', genre_id: 3, part_id: 5)
Training.create!(name: 'トーソローテーション', genre_id: 3, part_id: 5)

Training.create!(name: 'レッグプレス', genre_id: 3, part_id: 6)
Training.create!(name: 'レッグエクステンション', genre_id: 3, part_id: 6)
Training.create!(name: 'レッグカール', genre_id: 3, part_id: 6)


TrainingRecord.create!(record_id: 1, training_id: 1, weight: 80, rep: 7, set: 3)
TrainingRecord.create!(record_id: 1, training_id: 2, weight: 80, rep: 7, set: 3)
TrainingRecord.create!(record_id: 1, training_id: 3, weight: 80, rep: 7, set: 3)