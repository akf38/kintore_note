# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favorite, "モデルに関するテスト", type: :model do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:tweet) { create(:tweet, user_id: user1.id) }
  let!(:favorite) { build(:favorite, user_id: user2.id, tweet_id: tweet.id) }
  
  it "有効な内容で実際に保存してみる" do
    expect(tweet).to be_valid
  end
  
  context "バリデーションチェック" do
    it "user_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      favorite.user_id = ""
      expect(favorite).to be_invalid
      expect(favorite.errors[:user_id]).to include("を入力してください")
    end
    it "tweet_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      favorite.tweet_id = ""
      expect(favorite).to be_invalid
      expect(favorite.errors[:tweet_id]).to include("を入力してください")
    end
  end
  
end
