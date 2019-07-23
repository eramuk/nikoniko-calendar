class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:notice] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "new"
    end
  end

  def show
    @today_mood = @user.today_mood
    @calendar = @user.team_calendar
    @calendar_dates = Calendar::week(2).map {|x| x[:date]}
    render "show"
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully update"
      redirect_to @user
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation
    )
  end

  def correct_user
    begin
      @user = User.find(params[:id])
    rescue
    ensure
      redirect_to root_url unless current_user?(@user)
    end
  end
end
