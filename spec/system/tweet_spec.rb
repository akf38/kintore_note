require 'rails_helper'

  describe 'Tweetのテスト', js: true do
    
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:relationship1) { create(:relationship, follower_id: user1.id, followed_id: user2.id) }
    let!(:relationship2) { create(:relationship, follower_id: user2.id, followed_id: user1.id) }
    let!(:tweet1) { build(:tweet, content: 'あ'*rand(1..300)) }
    let!(:tweet2) { build(:tweet, content: 'あ'*rand(1..300)) }
    
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user1.email
      fill_in 'user[password]', with: user1.password
      click_button 'ログインする'
    end
    
    context 'Tweet新規投稿のテスト' do
      it 'ヘッダーの「つぶやく！」ボタンを押下後、ツイート一覧ページへ遷移する' do
        find('.navbar-toggler').click
        find(".tubuyaku").click
        expect(current_path).to eq '/tweets'
      end
      it 'ツイートを新規投稿し、自分自身のタイムラインに表示される' do
        find('.navbar-toggler').click
        find(".tubuyaku").click
        fill_in 'tweet[content]', with: tweet1.content
        click_on '投稿する'
        expect(current_path).to eq '/tweets'
        expect(page).to have_content "#{tweet1.content}"
      end
      
      it 'フォロー中の異なるユーザーの投稿が、タイムラインに表示されている' do
        find('.navbar-toggler').click
        find('.user-dropdown').click
        find('.sign-out').click
        expect(current_path).to eq '/'
        visit new_user_session_path
        fill_in 'user[email]', with: user2.email
        fill_in 'user[password]', with: user2.password
        click_button 'ログインする'
        find('.navbar-toggler').click
        find(".tubuyaku").click
        fill_in 'tweet[content]', with: tweet2.content
        click_on '投稿する'
        expect(current_path).to eq '/tweets'
        expect(page).to have_content "#{tweet2.content}"
        find('.navbar-toggler').click
        find('.user-dropdown').click
        find('.sign-out').click
        expect(current_path).to eq '/'
        visit new_user_session_path
        fill_in 'user[email]', with: user1.email
        fill_in 'user[password]', with: user1.password
        click_button 'ログインする'
        find('.navbar-toggler').click
        find(".tubuyaku").click
        expect(current_path).to eq '/tweets'
        expect(page).to have_content "#{tweet2.content}"
      end
    end
      
    context 'Tweet投稿削除のテスト' do
      it '自分の投稿したツイートが削除できる' do
        find('.navbar-toggler').click
        find(".tubuyaku").click
        fill_in 'tweet[content]', with: tweet1.content
        click_on '投稿する'
        expect(current_path).to eq '/tweets'
        expect(page).to have_content "#{tweet1.content}"
        find('#tweet-1-delete-link').click
        expect(current_path).to eq '/tweets'
        expect(page).to_not have_content "#{tweet1.content}"
      end
      it '他人の投稿したツイートを削除できない', js: true do
        find('.navbar-toggler').click
        find(".tubuyaku").click
        fill_in 'tweet[content]', with: tweet1.content
        click_on '投稿する'
        expect(current_path).to eq '/tweets'
        expect(page).to have_content "#{tweet1.content}"
        find('.navbar-toggler').click
        find('.user-dropdown').click
        find('.sign-out').click
        expect(current_path).to eq '/'
        visit new_user_session_path
        fill_in 'user[email]', with: user2.email
        fill_in 'user[password]', with: user2.password
        click_button 'ログインする'
        find('.navbar-toggler').click
        find(".tubuyaku").click
        expect(current_path).to eq '/tweets'
        expect(page).to have_content "#{tweet1.content}"
        expect(page).to_not have_css '#tweet-1-delete-link'
      end
    end
  end
  
  describe 'TweetCommentのテスト' , js: true do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:relationship1) { create(:relationship, follower_id: user1.id, followed_id: user2.id) }
    let!(:relationship2) { create(:relationship, follower_id: user2.id, followed_id: user1.id) }
    let!(:tweet1) { create(:tweet, content: 'あ'*rand(1..300), user_id: user1.id) }
    let!(:tweet2) { create(:tweet, content: 'あ'*rand(1..300), user_id: user2.id) }
    let!(:tweet_comment1) { create(:tweet_comment, content: 'い'*rand(1..300), tweet_id: tweet1.id, user_id: user2.id) }
    let!(:tweet_comment2) { build(:tweet_comment, content: 'い'*rand(1..300) ) }
    
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user1.email
      fill_in 'user[password]', with: user1.password
      click_button 'ログインする'
    end
    
    context 'TweetComment新規投稿のテスト' do
      it 'ヘッダーの「つぶやく！」ボタンを押下、個別ツイートページへ遷移する' do
        find('.navbar-toggler').click
        find(".tubuyaku").click
        expect(current_path).to eq '/tweets'
        find('#tweet-1-show-link').click
        expect(current_path).to eq '/tweets/1'
      end
      it '個別ツイートページにてツイートコメントを投稿できる' do
        find('.navbar-toggler').click
        find(".tubuyaku").click
        expect(current_path).to eq '/tweets'
        find('#tweet-1-show-link').click
        expect(current_path).to eq '/tweets/1'
        fill_in 'tweet_comment_content_form', with: tweet_comment1.content
        click_on '投稿する'
        expect(current_path).to eq '/tweets/1'
        expect(page).to have_content "#{tweet_comment1.content}"
      end
      it '自分の投稿したツイートコメントを削除できる' do
        find('.navbar-toggler').click
        find(".tubuyaku").click
        expect(current_path).to eq '/tweets'
        find('#tweet-1-show-link').click
        expect(current_path).to eq '/tweets/1'
        fill_in 'tweet_comment_content_form', with: tweet_comment2.content
        click_on '投稿する'
        expect(current_path).to eq '/tweets/1'
        expect(page).to have_content "#{tweet_comment2.content}"
        find('#tweet-comment-2-delete-link').click
        expect(current_path).to eq '/tweets/1'
        expect(page).to_not have_content "#{tweet_comment2.content}"
      end
      
      it '他ユーザーの投稿したツイートコメントは削除できない' do
        find('.navbar-toggler').click
        find(".tubuyaku").click
        expect(current_path).to eq '/tweets'
        find('#tweet-1-show-link').click
        expect(current_path).to eq '/tweets/1'
        expect(page).to have_content "#{tweet_comment1.content}"
        expect(page).to_not have_css '#tweet-comment-1-delete-link'
      end
    end
  end