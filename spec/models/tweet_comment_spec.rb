# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TweetComment, "モデルに関するテスト", type: :model do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:tweet) { create(:tweet, user_id: user1.id) }
  let!(:tweet_comment) { build(:tweet_comment, user_id: user2.id, tweet_id: tweet.id) }
  
  it "有効な内容で実際に保存してみる" do
    expect(tweet_comment).to be_valid
  end
  
  context "バリデーションチェック" do
    it "user_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      tweet_comment.user_id = ""
      expect(tweet_comment).to be_invalid
      expect(tweet_comment.errors[:user_id]).to include("を入力してください")
    end
    it "tweet_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      tweet_comment.tweet_id = ""
      expect(tweet_comment).to be_invalid
      expect(tweet_comment.errors[:tweet_id]).to include("を入力してください")
    end
    it "contentが空白の場合に、空白のエラーメッセージが返ってきているか" do
      tweet_comment.content = ""
      expect(tweet_comment).to be_invalid
      expect(tweet_comment.errors[:content]).to include("を入力してください")
    end
    it "contentが301字以上の場合に、エラーメッセージが返ってきているか" do
      tweet_comment.content = "あ"*301
      expect(tweet_comment).to be_invalid
      expect(tweet_comment.errors[:content]).to include("は300文字以内で入力してください")
    end
  end
  
end
