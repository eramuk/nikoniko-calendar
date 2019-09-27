class TeamInvitationMailer < ApplicationMailer
  def activation(team_invitation)
    @team_invitation = team_invitation
    mail to: @team_invitation.email, subject: "[#{Settings.app_name}] Team Invitation"
  end
end
