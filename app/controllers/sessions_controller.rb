class SessionsController < ApplicationController
  before_action :validate_redirect_path

  def new
    @redirect_path = params[:redirect_path]
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        remember(user)
        redirect_path = params[:redirect_path] ? params[:redirect_path] : user
        redirect_to redirect_path
      else
        message = "Account not activated. Check your email for the activation link."
        flash[:alert] = message
        redirect_to root_url
      end
    else
      flash.now[:alert] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def validate_redirect_path
    if !params[:redirect_path].blank? && !params[:redirect_path].match(/^\//)
      head :unprocessable_entity
    end
  end
end
