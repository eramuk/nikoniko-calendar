class TeamsController < ApplicationController
  include TeamEditable

  before_action :logged_in_user
  before_action :set_team, only: [:edit, :update, :destroy, :leave, :role, :remove_user]

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
    permission_user(:owner) or return
  end

  def update
    permission_user(:owner) or return
    if @team.update_attributes(team_params)
      flash[:notice] = "Successfully updated"
      redirect_to action: "index"
    else
      render "edit"
    end
  end

  def role
    permission_user(:owner) or return
    user = User.find(params[:team][:users].first)
    user_team = UserTeam.find_by(team_id: @team.id, user_id: user.id)
    if user_team.update_attributes(role: params[:team][:roles].first.to_i)
      flash[:notice] = "#{user.name} role changed to #{user.role(@team)}"
    else
      flash[:alert] = "Failed to change role #{user.role(@team)}"
    end
  end

  def destroy
    permission_user(:owner) or return
    @team.with_lock do
      if @team.destroy
        flash[:notice] = "Successfully deleted"
      else
        flash[:alert] = "Failed to delete"
      end
    end
    redirect_to action: "index"
  end

  def join
    invitation = TeamInvitation.find_by(token: params[:token])
    if invitation&.recipient&.id == current_user.id
      begin
        invitation.team.with_lock do
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
    begin
      @team.with_lock do
        if @team.last_owner?
          flash[:alert] = "You are last owner"
        else
          @team.leave(current_user.id)
          flash[:notice] = "Successfully leaved"
        end
      end
    rescue
      flash[:alert] = "Failed to leaved"
    end
    redirect_to action: "index"
  end

  def remove_user
    user = @team.users.find(team_params[:users].first)
    permission_user(:owner, @team) or return
    begin
      @team.with_lock do
        if user.owner?(@team) && @team.last_owner?
          flash[:alert] = "Team owner is only one"
        else
          @team.leave(user.id)
          flash[:notice] = "Successfully removed"
        end
      end
    rescue
      flash[:alert] = "Failed to removed"
    end
    redirect_to action: "edit"
  end

  private

  def team_params
    params.require(:team).permit(:name, users: [])
  end

  def set_team
    @team = current_user.teams.find(params[:id])
  end
end
