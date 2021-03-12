class ChangeDataStartDateToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :start_date, :datetime
  end
end
