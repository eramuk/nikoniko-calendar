class RemoveActivatedFromTeamInvitations < ActiveRecord::Migration[5.2]
  def change
    remove_column :team_invitations, :activated, :boolean
  end
end
