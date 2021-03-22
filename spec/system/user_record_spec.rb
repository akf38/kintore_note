require 'rails_helper'

describe 'ユーザー体型情報のテスト', js: true do
  context 'ユーザー新規登録時のテスト' do
    let!(:user1) { build(:user) }

    before do
      visit root_path
    end

    it '新規登録時に入力した体型情報がUserレコード、UserInfosレコードともに保存される' do
      find('.navbar-toggler').click
      click_on '新規登録'
      expect(current_path).to eq '/users/sign_up'
      fill_in 'user[name]', with: user1.name
      fill_in 'user[email]', with: user1.email
      fill_in 'user[password]', with: user1.password
      fill_in 'user[tall]', with: user1.tall
      fill_in 'user[weight]', with: user1.weight
      fill_in 'user[body_fat_percentage]', with: user1.body_fat_percentage
      fill_in 'user[password]', with: user1.password
      fill_in 'user[password_confirmation]', with: user1.password_confirmation
      click_on '登録する'
      expect(current_path).to eq '/users/1'
      expect(page).to have_content "#{user1.tall}"
      expect(page).to have_content "#{user1.weight}"
      expect(page).to have_content "#{user1.body_fat_percentage}"
      user = User.find_by(email: user1.email)
      expect(user1.weight).to eq user.user_infos.last.weight
      expect(user1.body_fat_percentage).to eq user.user_infos.last.body_fat_percentage
    end
  end

  context 'ユーザー体型情報更新時のテスト' do
    let!(:user1) { create(:user) }
    let!(:user2) { build(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user1.email
      fill_in 'user[password]', with: user1.password
      click_button 'ログインする'
    end

    it '「記録一覧はこちら」を押下した後、「今日の体型記録をつける」を押下すると、体型記録ページへ遷移する' do
      click_on '記録一覧はこちら>>'
      expect(current_path).to eq "/users/#{user1.id}/user_infos"
      click_on '今日の体型記録をつける>>'
      expect(current_path).to eq "/users/#{user1.id}/edit"
    end
    it '体型記録ページにて更新すると、Userレコード、UserInfosレコードともに更新される' do
      click_on '記録一覧はこちら>>'
      expect(current_path).to eq "/users/#{user1.id}/user_infos"
      click_on '今日の体型記録をつける>>'
      expect(current_path).to eq "/users/#{user1.id}/edit"
      fill_in 'user[tall]', with: user2.tall
      fill_in 'user[weight]', with: user2.weight
      fill_in 'user[body_fat_percentage]', with: user2.body_fat_percentage
      click_on '更新する'
      expect(current_path).to eq "/users/#{user1.id}"
      expect(page).to have_content "#{user2.tall}"
      expect(page).to have_content "#{user2.weight}"
      expect(page).to have_content "#{user2.body_fat_percentage}"
      user = User.find_by(email: user1.email)
      expect(user.weight).to eq user.user_infos.last.weight
      expect(user.body_fat_percentage).to eq user.user_infos.last.body_fat_percentage
    end
  end
end
