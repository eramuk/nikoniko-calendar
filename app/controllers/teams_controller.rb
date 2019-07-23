class TeamsController < ApplicationController
  before_action :logged_in_user

  def index
    @teams = current_user.teams
    render "index"
  end
end
