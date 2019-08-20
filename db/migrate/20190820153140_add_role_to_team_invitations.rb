class AddRoleToTeamInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :team_invitations, :role, :integer
  end
end
