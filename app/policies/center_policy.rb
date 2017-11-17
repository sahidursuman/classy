class CenterPolicy < ApplicationPolicy
  def can_edit?
    can_modify?
  end

  def can_report?
    member? && (user.working_center != record)
  end

  private
  def can_modify?
    user && user.center_manager? && (user.working_center == record)
  end
end
