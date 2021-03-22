# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Part, "モデルに関するテスト", type: :model do
  let!(:part) { create(:part) }

  it "有効な内容で実際に保存してみる" do
    expect(part).to be_valid
  end

  context "バリデーションチェック" do
    it "nameが空白の場合に、空白のエラーメッセージが返ってきているか" do
      part.name = ""
      expect(part).to be_invalid
      expect(part.errors[:name]).to include("を入力してください")
    end
  end
end
