# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Record, "モデルに関するテスト", type: :model do
  let!(:user) { create(:user) }
  let!(:record) { build(:record, user_id: user.id) }
  
  it "有効な内容で実際に保存してみる" do
    expect(record).to be_valid
  end
  
  context "バリデーションチェック" do
    it "user_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      record.user_id = ""
      expect(record).to be_invalid
      expect(record.errors[:user_id]).to include("を入力してください")
    end
  end
  
end
