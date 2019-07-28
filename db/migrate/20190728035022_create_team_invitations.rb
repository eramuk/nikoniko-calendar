class CreateTeamInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :team_invitations do |t|
      t.bigint :team_id
      t.bigint :sender_user_id
      t.bigint :recipient_user_id
      t.string :email
      t.string :activation_digest
      t.boolean :activated, default: false
      t.timestamps
    end
  end
end
