class RemoveAdminFromUserTeams < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_teams, :admin, :boolean
  end
end
