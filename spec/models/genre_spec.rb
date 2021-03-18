# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Genre, "モデルに関するテスト", type: :model do
  let!(:genre) { create(:genre) }
  
  it "有効な内容で実際に保存してみる" do
    expect(genre).to be_valid
  end
  
  context "バリデーションチェック" do
    it "nameが空白の場合に、空白のエラーメッセージが返ってきているか" do
      genre.name = ""
      expect(genre).to be_invalid
      expect(genre.errors[:name]).to include("を入力してください")
    end
  end
  
end
