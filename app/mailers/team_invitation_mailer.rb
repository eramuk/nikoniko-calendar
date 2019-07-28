class TeamInvitationMailer < ApplicationMailer
  def activation(team_invitation)
    @team_invitation = team_invitation
    mail to: @team_invitation.email, subject: "[#{ENV['APP_NAME']}] Team Invitation"
  end
end
