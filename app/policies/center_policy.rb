class CenterPolicy < ApplicationPolicy
  def can_edit?
    can_modify?
  end

  private
  def can_modify?
    user.center_manager? && (user.working_center == record)
  end
end
