# Preview all emails at http://localhost:3000/rails/mailers/team_invitation_mailer
class TeamInvitationMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/team_invitation_mailer/activation
  def activation
    team = Team.first
    sender = User.first
    recipient = User.first
    team_invitation = TeamInvitation.new(team_id: team.id, sender_id: sender.id, recipient_id: recipient.id)
    team_invitation.id = 1
    team_invitation.activation_token = TeamInvitation.new_token
    TeamInvitationMailer.activation(team_invitation)
  end
end
