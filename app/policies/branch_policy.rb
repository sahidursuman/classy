class BranchPolicy < ApplicationPolicy
  def can_review?
    member? && (user.normal_user? ? true : user.working_center.id != record.id)
  end
end
