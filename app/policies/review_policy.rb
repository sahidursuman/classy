class ReviewPolicy < ApplicationPolicy
  def edit?
    record_owner?
  end

  def update?
    record_owner?
  end

  def destroy?
    record_owner?
  end

  def can_vote?
    user && !record_owner?
  end

  def can_comment?
    user
  end
end
