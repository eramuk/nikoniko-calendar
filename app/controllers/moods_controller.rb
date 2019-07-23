class MoodsController < ApplicationController
  before_action :logged_in_user

  def create
    @mood = current_user.moods.build(mood_params)
    flash[:alert] = "Faild to post mood" unless @mood.save
    redirect_to root_url
  end

  def update
    @mood = current_user.moods.find(params[:id])
    flash[:alert] = "Faild to post mood" unless @mood.update(score: mood_params[:score])
    redirect_to controller: "users", action: "show"
  end

  private

  def mood_params
    params.require(:mood).permit(:date, :score)
  end
end
