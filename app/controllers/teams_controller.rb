class TeamsController < ApplicationController
  before_action :logged_in_user

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
      redirect_to controller: 'teams', action: 'index'
    else
      render "new"
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
