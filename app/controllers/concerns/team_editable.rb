module TeamEditable
  extend ActiveSupport::Concern

  def permission_user(allow_role, team = @team)
    if current_user.send(allow_role.to_s + "_or_higher?", team)
      true
    else
      flash[:alert] = "You don't have permission"
      redirect_to root_url
      false
    end
  end
end