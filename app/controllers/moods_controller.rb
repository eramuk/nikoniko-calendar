class MoodsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @mood = current_user.moods.build(mood_params)
    flash[:alert] = "Faild to post mood" unless @mood.save
    redirect_to root_url
  end

  private

  def mood_params
    params.require(:mood).permit(:date, :score)
  end
end
