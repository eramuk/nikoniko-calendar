module TeamEditable
  extend ActiveSupport::Concern

  def permission_user(allow_role)
    unless current_user.send(allow_role.to_s + "_or_higher?", @team)
      flash[:alert] = "You don't have permission"
      redirect_to action: "index"
    end
  end
end