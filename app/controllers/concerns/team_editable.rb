module TeamEditable
  extend ActiveSupport::Concern

  def permission_user(allow_role)
    if current_user.send(allow_role.to_s + "_or_higher?", @team)
      true
    else
      flash[:alert] = "You don't have permission"
      redirect_to controller: "teams", action: "index"
      false
    end
  end
end