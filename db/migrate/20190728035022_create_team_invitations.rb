class CreateTeamInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :team_invitations do |t|

      t.timestamps
    end
  end
end
