class CenterCommentPolicy < ApplicationPolicy
  def destroy?
    user.manage_branch? record.branch
  end
end
