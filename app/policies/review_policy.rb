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
end