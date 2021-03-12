class CreateTrainingRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :training_records do |t|
      t.integer :record_id, null: false
      t.integer :training_id, null: false
      t.integer :weight, null: false
      t.integer :reps, null: false
      t.integer :set, null: false
      t.timestamps
    end
  end
end
