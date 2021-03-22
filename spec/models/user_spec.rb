# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  it "有効な内容で実際に保存してみる" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  context "バリデーションチェック" do
    it "nameが空白の場合に、空白のエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, name: "")
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("を入力してください")
    end
    it "emailが空白の場合に、空白のエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, email: "")
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("が入力されていません。", "は有効でありません。")
    end
    it "emailの形式が正しくない場合に、不正な値のエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, email: "a" * 10)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("は有効でありません。")
    end
    it "emailが登録済みである場合に、登録済みのエラーメッセージが返ってきているか" do
      FactoryBot.create(:user, email: "abcd@abcd.com")
      user = FactoryBot.build(:user, email: "abcd@abcd.com")
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("は既に使用されています。")
    end
    it "password_confirmationが空白の場合に、空白のエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, password_confirmation: "")
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    it "passwordとpassword_confirmationが両方空白の場合に、空白のエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, password: "", password_confirmation: "")
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("が入力されていません。")
    end
    it "passwordとpassword_confirmationが6文字未満の場合に、文字数のエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, password: "a" * 5, password_confirmation: "a" * 5)
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end
    it "passwordとpassword_confirmationが一致しない場合に、不一致のエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, password: "a" * 6, password_confirmation: "a" * 10)
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    it "tallがマイナス値または0の場合に、0以上での入力を指示するエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, tall: rand(-999..0))
      expect(user). to be_invalid
      expect(user.errors[:tall]).to include("は0より大きい値にしてください")
    end
    it "weightがマイナス値または0の場合に、0以上での入力を指示するエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, weight: rand(-999..0))
      expect(user). to be_invalid
      expect(user.errors[:weight]).to include("は0より大きい値にしてください")
    end
    it "body_fat_percentageがマイナス値または0の場合に、0以上での入力を指示するエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, body_fat_percentage: rand(-999..0))
      expect(user). to be_invalid
      expect(user.errors[:body_fat_percentage]).to include("は0より大きい値にしてください")
    end
    it "body_fat_percentageが100以上の場合に、100未満での入力を指示するエラーメッセージが返ってきているか" do
      user = FactoryBot.build(:user, body_fat_percentage: rand(100..999))
      expect(user). to be_invalid
      expect(user.errors[:body_fat_percentage]).to include("は100より小さい値にしてください")
    end
  end
end
