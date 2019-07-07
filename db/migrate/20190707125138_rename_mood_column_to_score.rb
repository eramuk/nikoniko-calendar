class RenameMoodColumnToScore < ActiveRecord::Migration[5.2]
  def change
    rename_column :moods, :mood, :score
  end
end
