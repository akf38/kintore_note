class RenameRepsColumnToTrainingRecords < ActiveRecord::Migration[5.2]
  def change
    rename_column :training_records, :reps, :rep
  end
end
