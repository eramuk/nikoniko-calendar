class TeamInvitationsController < ApplicationController
  include TeamEditable

  before_action :logged_in_user

  def new
    @team_invitation = TeamInvitation.new
    @team = current_user.teams.find(params[:team_id])
    permission_user(:member) or return
    render "new"
  end

  def create
    @team = current_user.teams.find(team_invitation_params[:team_id])
    permission_user(:member) or return

    if team_invitation_params[:email].empty?
      @team_invitation = TeamInvitation.new
      @team_invitation.errors.add(:email, :blank)
      render "new" and return
    end

    recipient = User.find_by(email: team_invitation_params[:email], activated: true)
    unless recipient
      @team_invitation = TeamInvitation.new
      @team_invitation.email = team_invitation_params[:email]
      @team_invitation.errors.add(:email, "not found")
      render "new" and return
    end

    @team_invitation = TeamInvitation.new(team_invitation_params)
    @team_invitation.sender_id = current_user.id
    @team_invitation.recipient_id = recipient.id
    if @team_invitation.save
      flash[:notice] = "Email sent with invitations"
      TeamInvitationMailer.activation(@team_invitation).deliver_now
    else
      flash[:alert] = "Failed to invitation"
    end

    redirect_to action: "new", team_id: @team.id
  end

  private

  def team_invitation_params
    params.require(:team_invitation).permit(:team_id, :email, :role)
  end
end
