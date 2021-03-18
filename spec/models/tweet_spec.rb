# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweet, "モデルに関するテスト", type: :model do
  let!(:user) { create(:user) }
  let!(:tweet) { build(:tweet, user_id: user.id) }
  
  it "有効な内容で実際に保存してみる" do
    expect(tweet).to be_valid
  end
  
  context "バリデーションチェック" do
    it "user_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      tweet.user_id = ""
      expect(tweet).to be_invalid
      expect(tweet.errors[:user_id]).to include("を入力してください")
    end
    it "contentが空白の場合に、空白のエラーメッセージが返ってきているか" do
      tweet.content = ""
      expect(tweet).to be_invalid
      expect(tweet.errors[:content]).to include("を入力してください")
    end
    it "contentが301字以上の場合に、エラーメッセージが返ってきているか" do
      tweet.content = "あ"*301
      expect(tweet).to be_invalid
      expect(tweet.errors[:content]).to include("は300文字以内で入力してください")
    end
  end
  
end
