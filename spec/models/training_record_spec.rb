# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TrainingRecord, "モデルに関するテスト", type: :model do
  let!(:user) { create(:user) }
  let!(:record) { create(:record, user_id: user.id) }
  let!(:genre) { create(:genre) }
  let!(:part) { create(:part) }
  let!(:training) { create(:training, genre_id: genre.id, part_id: part.id) }
  let!(:training_record) { build(:training_record, record_id: record.id, training_id: training.id) }
  
  it "有効な内容で実際に保存してみる" do
    expect(training_record).to be_valid
  end
  
  context "バリデーションチェック" do
    it "training_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      training_record.training_id = ""
      expect(training_record).to be_invalid
      expect(training_record.errors[:training_id]).to include("を入力してください")
    end
    it "record_idが空白の場合に、空白のエラーメッセージが返ってきているか" do
      training_record.record_id = ""
      expect(training_record).to be_invalid
      expect(training_record.errors[:record_id]).to include("を入力してください")
    end
    it "weightが空白の場合に、空白のエラーメッセージが返ってきているか" do
      training_record.weight = ""
      expect(training_record).to be_invalid
      expect(training_record.errors[:weight]).to include("を入力してください")
    end
    it "repが空白の場合に、空白のエラーメッセージが返ってきているか" do
      training_record.rep = ""
      expect(training_record).to be_invalid
      expect(training_record.errors[:rep]).to include("を入力してください")
    end
    it "setが空白の場合に、空白のエラーメッセージが返ってきているか" do
      training_record.set = ""
      expect(training_record).to be_invalid
      expect(training_record.errors[:set]).to include("を入力してください")
    end
    it "weightがマイナス値の場合に、0以上での入力を指示するエラーメッセージが返ってきているか" do
      training_record.weight = rand(-999..-1)
      expect(training_record). to be_invalid
      expect(training_record.errors[:weight]).to include("は0以上の値にしてください")
    end
    it "repがマイナス値の場合に、0以上での入力を指示するエラーメッセージが返ってきているか" do
      training_record.rep = rand(-999..-1)
      expect(training_record). to be_invalid
      expect(training_record.errors[:rep]).to include("は0以上の値にしてください")
    end
    it "setがマイナス値の場合に、0以上での入力を指示するエラーメッセージが返ってきているか" do
      training_record.set = rand(-999..-1)
      expect(training_record). to be_invalid
      expect(training_record.errors[:set]).to include("は0以上の値にしてください")
    end
  end
  
  
end
