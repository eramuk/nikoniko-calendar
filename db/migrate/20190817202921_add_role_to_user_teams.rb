class AddRoleToUserTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :user_teams, :role, :integer
  end
end
