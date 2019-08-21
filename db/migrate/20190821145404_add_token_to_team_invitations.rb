class AddTokenToTeamInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :team_invitations, :token, :string
    add_index :team_invitations, [:token], unique: true
  end
end
