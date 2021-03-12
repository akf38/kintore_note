class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.integer :genre_id, null: false
      t.integer :part_id, null: false
      t.string  :name, null: false
      t.string  :image_id
      t.timestamps
    end
  end
end
