class TeamInvitationsController < ApplicationController
  before_action :logged_in_user

  def new
    @team_invitation = TeamInvitation.new
    @team = current_user.teams.find(params[:team_id])
    render "new"
  end

  def create
    @team = current_user.teams.find(team_invitation_params[:team_id])

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

  def edit
    team_invitation = TeamInvitation.find_by(id: params[:id], activated: false)
    if team_invitation&.recipient.id == current_user.id && team_invitation.authenticated?(params[:token])
      begin
        ActiveRecord::Base.transaction do
          team_invitation.team.join(current_user.id)
          team_invitation.update(activated: true)
        end
        flash[:notice] = "Join #{team_invitation.team.name}!"
      rescue
        flash[:alert] = "Faild to join #{team_invitation.team.name}"
      ensure
        redirect_to current_user
      end
    else
      flash[:alert] = "Invalid activation link"
      redirect_to root_url
    end
  end

  private

  def team_invitation_params
    params.require(:team_invitation).permit(:team_id, :email)
  end
end
