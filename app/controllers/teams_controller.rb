class TeamsController < ApplicationController
  before_action :logged_in_user
  before_action :get_team, only: [:edit, :update, :destroy, :leave]

  def index
    @teams = current_user.teams
    render "index"
  end

  def new
    @team = current_user.teams.build
  end

  def create
    @team = current_user.teams.build(team_params)
    if current_user.save
      flash[:notice] = "Successfully created"
      redirect_to action: "index"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @team.update_attributes(team_params)
      flash[:notice] = "Successfully updated"
      redirect_to action: "index"
    else
      render "edit"
    end
  end

  def destroy
    if @team.destroy
      flash[:notice] = "Successfully deleted"
    else
      flash[:alert] = "Failed to delete"
    end
    redirect_to action: "index"
  end

  def join
    invitation = TeamInvitation.find_by(token: params[:token])
    if invitation&.recipient.id == current_user.id
      begin
        ActiveRecord::Base.transaction do
          invitation.team.join(invitation.recipient.id, invitation.role)
          invitation.destroy
        end
        flash[:notice] = "Join #{invitation.team.name}!"
      rescue
        flash[:alert] = "Faild to join #{invitation.team.name}"
      end
      redirect_to current_user
    else
      flash[:alert] = "Invalid activation link"
      redirect_to root_url
    end
  end

  def leave
    if @team.last_user?
      flash[:alert] = "You are last user"
    elsif @team.leave(current_user.id)
      flash[:notice] = "Successfully leaved"
    else
      flash[:alert] = "Failed to leaved"
    end
    redirect_to action: "index"
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def get_team
    @team = current_user.teams.find(params[:id])
  end
end
