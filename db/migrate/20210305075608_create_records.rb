class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :user_id, null: false
      t.text    :comment
      t.string  :image_id
      t.timestamps
    end
  end
end
