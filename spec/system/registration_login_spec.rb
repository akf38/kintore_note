require 'rails_helper'

  describe '新規登録のテスト' do
    
    it 'トップページで新規登録画面へのリンクを押下すると新規登録画面が表示される' do
      visit root_path
      click_link '新規登録'
      expect(current_path).to eq '/users/sign_up'
    end
    
    context '新規登録フォームのテスト' do
      let!(:user) { build(:user) }
      before do
        visit new_user_registration_path
      end
      it '必要項目を入力し、新規登録の成功を確認' do
        fill_in 'user[name]', with: user.name
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password_confirmation
        click_button '登録する'
        expect(page).to have_content 'アカウント登録が完了しました。'
        expect(page).to have_content "#{user.name}"
      end
    end
        
      
    context '新規登録成功後のテスト' do
      let!(:user) { build(:user) }
      before do
        visit new_user_registration_path
        fill_in 'user[name]', with: user.name
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password_confirmation
        click_button '登録する'
      end
      context '新規登録後、ヘッダがログイン後の表示に変わっている' do
        it '「マイページ」と表示される' do
          expect(page).to have_link 'マイページ'
        end
        it '「記録する」と表示される' do
          expect(page).to have_link'記録する'
        end
        it '「カート」と表示される' do
          expect(page).to have_link 'つぶやく'
        end
        it '「ログアウト」と表示される' do
          expect(page).to have_link '仲間を探す'
        end
      end
    end
  end
  
  describe 'ログイン、ログアウトのテスト' do
    
    it 'トップページでログイン画面へのリンクを押下するとログイン画面が表示される' do
      visit root_path
      click_link 'ログイン'
      expect(current_path).to eq '/users/sign_in'
    end
    
    context 'ログインフォームのテスト' do
      let!(:user) { create(:user) }
      before do
        visit new_user_session_path
      end
      it '必要項目を入力し、新規登録の成功を確認' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログインする'
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content "#{user.name}"
      end
    end
    
    context 'ログイン成功後のテスト', js: true do
      let!(:user) { create(:user) }
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログインする'
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content "#{user.name}"
      end
      context 'ログイン後、ヘッダがログイン後の表示に変わっている' do
        it '「マイページ」と表示される' do
          expect(page).to have_link 'マイページ'
        end
        it '「記録する」と表示される' do
          expect(page).to have_link'記録する'
        end
        it '「カート」と表示される' do
          expect(page).to have_link 'つぶやく'
        end
        it '「ログアウト」と表示される' do
          expect(page).to have_link '仲間を探す'
        end
      end
      it 'ログアウトボタン押下で、ログアウトできる' do
        find('.user-dropdown').click
        find('.sign-out').click
        expect(current_path).to eq '/'
        expect(page).to_not have_link 'マイページ'
      end
    end
  end