class MoodsController < ApplicationController
  before_action :logged_in_user

  def create
    @mood = current_user.today_mood
    flash[:alert] = "Faild to post mood" unless @mood.update(mood_params)
    redirect_to user_url(current_user)
  end

  private

  def mood_params
    params.require(:mood).permit(:score)
  end
end
