# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Training, "モデルに関するテスト", type: :model do
  let!(:genre) { create(:genre) }
  let!(:part) { create(:part) }
  let!(:training) { build(:training, genre_id: genre.id, part_id: part.id) }

  it "有効な内容で実際に保存してみる" do
    expect(training).to be_valid
  end

  context "バリデーションチェック" do
    it "genre_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      training.genre_id = ""
      expect(training).to be_invalid
      expect(training.errors[:genre_id]).to include("を入力してください")
    end
    it "part_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      training.part_id = ""
      expect(training).to be_invalid
      expect(training.errors[:part_id]).to include("を入力してください")
    end
  end
end
