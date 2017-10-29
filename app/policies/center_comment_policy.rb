class CenterCommentPolicy < ApplicationPolicy
  def edit?
    can_modify?
  end

  def update?
    can_modify?
  end

  def destroy?
    user.manage_branch? record.branch
  end

  private
  def can_modify?
    record_owner? && user.manage_branch?(record.branch)
  end
end
