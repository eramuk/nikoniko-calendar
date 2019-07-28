class TeamInvitationsController < ApplicationController
  before_action :logged_in_user

  def new
    @team = current_user.teams.find(params[:team_id])
    @team_invitation = TeamInvitation.new
    render "new"
  end

  private

  def team_invitation_params
    params.require(:invitation_team_params).permit(:team_id)
  end
end
