class UserCommentPolicy < ApplicationPolicy
  def destroy?
    record_owner?
  end
end
