# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 必須ファイル
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

# ここまで必須ファイル

# ここから任意のテストデータ

30.times do |u_number|
  user = User.create!(name: "テスト太郎#{u_number+1}",
              email: "test#{u_number+1}@test.com",
              tall: rand(150..200),
              weight: rand(60..100),
              body_fat_percentage: rand(5..25),
              password: 'testpass',
              start_date: "#{rand(2000..2016)}-#{rand(1..12)}-#{rand(1..28)} 15:00:00",
              password_confirmation: 'testpass')
              
  5.times do |ui_number|
    UserInfo.create!(user_id: user.id,
                weight: rand(50..90),
                body_fat_percentage: rand(6..35),
                created_at: "2021-#{rand(1..2)}-#{rand(1..28)} 04:39:22")
  end
  
  5.times do |r_number|
    month = 3
    day = rand(1..28)
  
    record = Record.create!(user_id: user.id,
              start_time: "2021-#{month}-#{day} 04:39:22",
              created_at: "2021-#{month}-#{day} 04:39:22")
    6.times do |tr_number|
      TrainingRecord.create!(record_id: record.id,
                           training_id: rand(1..30), 
                                weight: rand(20..120), 
                                   rep: rand(1..15), 
                                   set: rand(1..8),
                            created_at: record.created_at)
    end
  end
  
  5.times do |t_number|
    Tweet.create!(user_id: user.id,
                content: "ああ〜筋トレ行きたいなあ、私はテスト太郎#{user.id}です。",
                created_at: "2021-#{rand(2..3)}-#{rand(1..28)} 04:39:22" )
  end
  
end

Tweet.all.each do |tweet|
  user = User.find(rand(1..30))
  TweetComment.create!(user_id: user.id,
                        tweet_id: tweet.id,
                        content: '僕も筋トレ行きたいなあ。今度ご一緒しませんか！',
                        created_at: "2021-#{rand(2..3)}-#{rand(1..28)} 04:39:22" )
end  



