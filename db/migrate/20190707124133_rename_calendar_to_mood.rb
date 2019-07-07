class RenameCalendarToMood < ActiveRecord::Migration[5.2]
  def change
    rename_table :calendars, :moods
  end
end
