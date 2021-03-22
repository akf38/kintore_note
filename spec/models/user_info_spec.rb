# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserInfo, "モデルに関するテスト", type: :model do
  let!(:user) { create(:user) }
  let!(:user_info) { build(:user_info, user_id: user.id) }

  it "有効な内容で実際に保存してみる" do
    expect(user_info).to be_valid
  end

  context "バリデーションチェック" do
    it "weightが空白の場合に、空白のエラーメッセージが返ってきているか" do
      user_info.weight = ""
      expect(user_info).to be_invalid
      expect(user_info.errors[:weight]).to include("を入力してください")
    end
    it "body_fat_percentageが空白の場合に、空白のエラーメッセージが返ってきているか" do
      user_info.body_fat_percentage = ""
      expect(user_info).to be_invalid
      expect(user_info.errors[:body_fat_percentage]).to include("を入力してください")
    end
    it "weightがマイナス値または0の場合に、0以上での入力を指示するエラーメッセージが返ってきているか" do
      user_info.weight = rand(-999..0)
      expect(user_info). to be_invalid
      expect(user_info.errors[:weight]).to include("は0より大きい値にしてください")
    end
    it "body_fat_percentageがマイナス値または0の場合に、0以上での入力を指示するエラーメッセージが返ってきているか" do
      user_info.body_fat_percentage = rand(-999..0)
      expect(user_info). to be_invalid
      expect(user_info.errors[:body_fat_percentage]).to include("は0より大きい値にしてください")
    end
    it "body_fat_percentageが100以上の場合に、100未満での入力を指示するエラーメッセージが返ってきているか" do
      user_info.body_fat_percentage = rand(100..999)
      expect(user_info). to be_invalid
      expect(user_info.errors[:body_fat_percentage]).to include("は100より小さい値にしてください")
    end
  end
end
