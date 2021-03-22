require 'rails_helper'

describe '筋トレ記録のテスト', js: true do
  context '筋トレ新規投稿のテスト' do
    let!(:user) { create(:user) }
    let!(:genre) { create(:genre) }
    let!(:part1) { create(:part, name: '胸') }
    let!(:part2) { create(:part, name: '腹') }
    let!(:training1) do
      create(:training,
             genre_id: genre.id,
             part_id: part1.id,
             name: 'ベンチプレス')
    end
    let!(:training2) do
      create(:training,
             genre_id: genre.id,
             part_id: part2.id,
             name: 'アブドミナル')
    end
    let!(:training_record1) do
      build(:training_record,
            weight: rand(0..999),
            rep: rand(0..999),
            set: rand(0..999))
    end
    let!(:training_record2) do
      build(:training_record,
            weight: rand(0..999),
            rep: rand(0..999),
            set: rand(0..999))
    end

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end

    it 'ヘッダーの「記録する」ボタンを押下後、トレーニングノートページへ遷移する' do
      find('.navbar-toggler').click
      click_on '記録する！'
      expect(current_path).to eq '/records'
    end
    it 'トレーニングノートページにて「今日のトレーニングを記録する」リンクを押下後、（新規の）今日のトレーニング詳細ページへ遷移する。' do
      find('.navbar-toggler').click
      click_on '記録する！'
      click_link '今日のトレーニングを記録する'
      expect(current_path).to eq '/records/new'
    end
    it '（新規）今日のトレーニング詳細ページにてトレーニング記録をつける。' do
      find('.navbar-toggler').click
      click_on '記録する！'
      click_link '今日のトレーニングを記録する'
      select "#{part1.name}", from: 'training_record_part_id'
      select "#{training1.name}", from: 'training_record_training_id'
      fill_in 'training_record[weight]', with: training_record1.weight
      fill_in 'training_record[rep]', with: training_record1.rep
      fill_in 'training_record[set]', with: training_record1.set
      click_on '記録する'
      expect(page).to have_content "#{training1.name}"
      expect(page).to have_content "#{training_record1.weight}"
      expect(page).to have_content "#{training_record1.rep}"
      expect(page).to have_content "#{training_record1.set}"
    end
    it '（2回目）今日のトレーニング詳細ページにてトレーニング記録をつける。' do
      find('.navbar-toggler').click
      click_on '記録する！'
      click_link '今日のトレーニングを記録する'
      select "#{part1.name}", from: 'training_record_part_id'
      select "#{training1.name}", from: 'training_record_training_id'
      fill_in 'training_record[weight]', with: training_record1.weight
      fill_in 'training_record[rep]', with: training_record1.rep
      fill_in 'training_record[set]', with: training_record1.set
      click_on '記録する'
      expect(page).to have_content "#{training1.name}"
      expect(page).to have_content "#{training_record1.weight}"
      expect(page).to have_content "#{training_record1.rep}"
      expect(page).to have_content "#{training_record1.set}"

      select "#{part2.name}", from: 'training_record_part_id'
      select "#{training2.name}", from: 'training_record_training_id'
      fill_in 'training_record[weight]', with: training_record2.weight
      fill_in 'training_record[rep]', with: training_record2.rep
      fill_in 'training_record[set]', with: training_record2.set
      click_on '記録する'

      expect(page).to have_content "#{training1.name}"
      expect(page).to have_content "#{training_record1.weight}"
      expect(page).to have_content "#{training_record1.rep}"
      expect(page).to have_content "#{training_record1.set}"
      expect(page).to have_content "#{training2.name}"
      expect(page).to have_content "#{training_record2.weight}"
      expect(page).to have_content "#{training_record2.rep}"
      expect(page).to have_content "#{training_record2.set}"
    end
  end

  context '筋トレ記録編集のテスト' do
    let!(:user) { create(:user) }
    let!(:genre) { create(:genre) }
    let!(:part1) { create(:part, name: '胸') }
    let!(:part2) { create(:part, name: '腹') }
    let!(:training1) { create(:training, genre_id: genre.id, part_id: part1.id, name: 'ベンチプレス') }
    let!(:training2) { create(:training, genre_id: genre.id, part_id: part2.id, name: 'アブドミナル') }
    let!(:training3) { create(:training, genre_id: genre.id, part_id: part1.id, name: 'ダンベルフライ') }
    let!(:record) { create(:record, user_id: user.id) }
    let!(:training_record1) do
      create(:training_record,
             training_id: training1.id,
             record_id: record.id,
             weight: rand(0..999),
             rep: rand(0..999),
             set: rand(0..999))
    end
    let!(:training_record2) do
      create(:training_record,
             training_id: training2.id,
             record_id: record.id,
             weight: rand(0..999),
             rep: rand(0..999),
             set: rand(0..999))
    end

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end

    it 'ヘッダーの「記録する」ボタンを押下後、トレーニングノートページへ遷移する' do
      find('.navbar-toggler').click
      click_on '記録する！'
      expect(current_path).to eq '/records'
    end
    it '今日のトレーニング記録をつけた後、それを編集する' do
      find('.navbar-toggler').click
      click_on '記録する！'
      click_link '今日のトレーニングを記録する'
      select "#{part1.name}", from: 'training_record_part_id'
      select "#{training1.name}", from: 'training_record_training_id'
      fill_in 'training_record[weight]', with: training_record1.weight
      fill_in 'training_record[rep]', with: training_record1.rep
      fill_in 'training_record[set]', with: training_record1.set
      click_on '記録する'
      expect(page).to have_content "#{training1.name}"
      expect(page).to have_content "#{training_record1.weight}"
      expect(page).to have_content "#{training_record1.rep}"
      expect(page).to have_content "#{training_record1.set}"

      find('.navbar-toggler').click
      click_on '記録する！'
      expect(current_path).to eq "/records"
      click_on '詳細'
      expect(current_path).to eq "/records/1"
      click_link 'トレーニング内容の編集はこちら'
      expect(current_path).to eq "/records/1/edit"
      fill_in "weight-field-#{training_record1.id}", with: 1000
      fill_in "rep-field-#{training_record1.id}", with: 1001
      fill_in "set-field-#{training_record1.id}", with: 1002
      find("#update-btn-#{training_record1.id}").click
      expect(current_path).to eq "/records/1"
      expect(page).to have_content "1000"
      expect(page).to have_content "1001"
      expect(page).to have_content "1002"
    end
  end
end
