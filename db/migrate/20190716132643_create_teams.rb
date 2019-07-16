class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.bigint :user_id
      t.text :name
      t.index ["user_id", "name"], unique: true
      t.timestamps
    end
  end
end
