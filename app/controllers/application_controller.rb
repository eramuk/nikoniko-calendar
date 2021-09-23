class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      flash[:alert] = "Please log in."
      redirect_params = params[:redirect] ? {redirect_path: request.fullpath} : nil
      redirect_to login_url(redirect_params)
    end
  end
end
