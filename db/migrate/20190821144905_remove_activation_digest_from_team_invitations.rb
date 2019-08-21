class RemoveActivationDigestFromTeamInvitations < ActiveRecord::Migration[5.2]
  def change
    remove_column :team_invitations, :activation_digest, :string
  end
end
