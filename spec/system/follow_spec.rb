require 'rails_helper'

describe 'フォロー機能のテスト', js: true do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:user4) { create(:user) }
  let!(:user5) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_button 'ログインする'
  end

  context 'ユーザー全体ページのテスト' do
    it 'ヘッダーの「仲間を探す！」ボタンを押下後、ユーザーリストページへ遷移する' do
      expect(current_path).to eq "/users/#{user1.id}"
      find('.navbar-toggler').click
      find(".nakama").click
      expect(current_path).to eq '/users'
    end
    it '特定のユーザーのフォローボタンを押下すると、新規relationshipデータが保存される' do
      find('.navbar-toggler').click
      find(".nakama").click
      expect(current_path).to eq '/users'
      expect do # ajax使用部分でajax処理完了まで待ってから、Relationshipデータ数の変更を確認している。間に2個ほどテストを挟む。
        find(".follow-follower-button-2").click
        expect(current_path).to eq '/users'
        expect(page).to have_css '.follow-follower-button-2'
      end.to change(Relationship, :count).by(1)
    end
    it '特定のユーザーのフォローボタンを押下すると、特定ユーザーのボタンが「フォローする!」から「フォローを外す」に変更される' do
      find('.navbar-toggler').click
      find(".nakama").click
      expect(current_path).to eq '/users'
      expect(find('.follow-follower-button-3').value).to eq 'フォローする！'
      using_wait_time 5 do
        expect { find(".follow-follower-button-3").click }.to change(Relationship, :count).by(1)
      end
      find(".follow-follower-button-3").click
       wait_for_ajax do
        expect(find('.follow-follower-button-3').value).to eq 'フォローを外す'
      end
    end
  end

  context 'ユーザー個別ページでのテスト' do
    it 'ヘッダーの「仲間を探す！」ボタンを押下後、ユーザーリストページへ遷移する' do
      find('.navbar-toggler').click
      find(".nakama").click
      expect(current_path).to eq '/users'
    end
    it 'ユーザーリストページにて個別ユーザー名を押下し、ユーザー個別ページへ遷移する' do
      find('.navbar-toggler').click
      find(".nakama").click
      expect(current_path).to eq '/users'
      click_on "#{user4.name}"
      expect(current_path).to eq '/users/4'
    end
    it 'ユーザー個別ページにてフォローボタンを押下すると、新規relationshipデータが保存される' do
      find('.navbar-toggler').click
      find(".nakama").click
      expect(current_path).to eq '/users'
      click_on "#{user4.name}"
      expect(current_path).to eq '/users/4'
      using_wait_time 5 do
        expect { find(".follow-follower-button-4").click }.to change(Relationship, :count).by(1)
      end
      expect(current_path).to eq '/users/4'
    end
    it 'ユーザー個別ページにてフォローボタンを押下すると、特定ユーザーのボタンが「フォローする!」から「フォローを外す」に変更される' do
      find('.navbar-toggler').click
      find(".nakama").click
      expect(current_path).to eq '/users'
      click_on "#{user4.name}"
      expect(current_path).to eq '/users/4'
      expect(find('.follow-follower-button-4').value).to eq 'フォローする！'
      using_wait_time 5 do
        expect { find(".follow-follower-button-4").click }.to change(Relationship, :count).by(1)
      end
      find(".follow-follower-button-4").click
      using_wait_time 5 do
        expect { find(".follow-follower-button-4").click }.to change(Relationship, :count).by(1)
      end
      find(".follow-follower-button-4").click
      using_wait_time 5 do
        expect(find('.follow-follower-button-4').value).to eq 'フォローを外す'
      end
      expect(current_path).to eq '/users/4'
    end
  end
end
