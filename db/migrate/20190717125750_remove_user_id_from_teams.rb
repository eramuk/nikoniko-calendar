class RemoveUserIdFromTeams < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :user_id, :bigint
  end
end
