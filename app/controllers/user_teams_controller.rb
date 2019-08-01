class UserTeamsController < ApplicationController
  before_action :logged_in_user

  def destroy
    if current_user.user_teams.find(params[:id]).destroy
      flash[:notice] = "Successfully leaved"
    else
      flash[:alert] = "Failed to leave"
    end
    redirect_to controller: "teams", action: "index"
  end
end
