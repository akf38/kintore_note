class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  def up
    # Not Null制約を外す場合　not nullを外したいカラム横にtrueを記載
    change_column_null :users, :profile,             true
    change_column_null :users, :tall,                true
    change_column_null :users, :weight,              true
    change_column_null :users, :body_fat_percentage, true
  end

  def down
    change_column_null :users, :profile,             false
    change_column_null :users, :tall,                false
    change_column_null :users, :weight,              false
    change_column_null :users, :body_fat_percentage, false
  end
end
