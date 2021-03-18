require 'rails_helper'

RSpec.describe Relationship, "モデルに関するテスト", type: :model do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:relationship) { build(:relationship, follower_id: user1.id, followed_id: user2.id) }
  
  it "有効な内容で実際に保存してみる" do
    expect(relationship).to be_valid
  end
  
  context "バリデーションチェック" do
    it "following_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      relationship.follower_id = ""
      expect(relationship).to be_invalid
      expect(relationship.errors[:follower_id]).to include("を入力してください")
    end
    it "follower_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      relationship.followed_id = ""
      expect(relationship).to be_invalid
      expect(relationship.errors[:followed_id]).to include("を入力してください")
    end
  end
    
end
