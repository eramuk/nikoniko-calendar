class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.bigint :user_id
      t.date :date
      t.integer :mood
      t.timestamp
      t.index ["user_id", "date"], unique: true
    end
  end
end
