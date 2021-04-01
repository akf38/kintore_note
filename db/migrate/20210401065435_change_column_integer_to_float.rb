class ChangeColumnIntegerToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :training_records, :weight, :float
    change_column :training_records, :rep, :float
    change_column :training_records, :set, :float
    change_column :user_infos, :weight, :float
    change_column :user_infos, :body_fat_percentage, :float
    change_column :users, :tall, :float
    change_column :users, :weight, :float
    change_column :users, :body_fat_percentage, :float
  end
end
