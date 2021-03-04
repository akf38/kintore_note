class CreateUserInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_infos do |t|
      t.integer :user_id,             null: false
      t.integer :weight,              null: false
      t.integer :body_fat_percentage, null: false
      t.timestamps
    end
  end
end
