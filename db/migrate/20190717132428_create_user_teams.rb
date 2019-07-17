class CreateUserTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :user_teams do |t|
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.references :team, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
