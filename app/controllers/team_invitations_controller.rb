class TeamInvitationsController < ApplicationController
  before_action :logged_in_user
  before_action :get_team, only: ["new", "create"]

  def new
    @team_invitation = TeamInvitation.new
    render "new"
  end

  def create
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

    redirect_to action: "new", team_invitation: {team_id: @team.id}
  end

  private

  def team_invitation_params
    params.require(:team_invitation).permit(:team_id, :email)
  end

  def get_team
    @team = current_user.teams.find(team_invitation_params[:team_id])
  end
end
