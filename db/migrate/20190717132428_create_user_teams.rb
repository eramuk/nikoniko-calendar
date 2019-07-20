class CreateUserTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :user_teams do |t|
      t.references :user, foreign_key: { on_delete: :cascade }
      t.references :team, foreign_key: { on_delete: :cascade }
      t.boolean :admin, default: false, null: false

      t.timestamps
    end
  end
end
