class ChangeIsDeletedOfUsers < ActiveRecord::Migration[5.2]
  # Users is_deletedのデフォルト値を追加
  def up
    change_column :users, :is_deleted, :boolean, default: false
  end

  def down
    change_column :users, :is_deleted, :boolean
  end
end
