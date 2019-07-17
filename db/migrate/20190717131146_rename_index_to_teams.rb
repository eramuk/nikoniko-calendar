class RenameIndexToTeams < ActiveRecord::Migration[5.2]
  def change
    rename_index :teams, 'index_teams_on_user_id_and_name', 'index_teams_on_name'
  end
end
