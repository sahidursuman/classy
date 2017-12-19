class BranchPolicy < ApplicationPolicy
  def can_review?
    member? && (user.normal_user? ? true : user.working_center.id != record.id)
  end

  def new?
    user.try :center_manager?
  end

  def edit?
    can_modify?
  end

  def update?
    can_modify?
  end

  private
  def can_modify?
    manager? && user.branches_under_management.include?(record)
  end
end
