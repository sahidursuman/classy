class ReviewPolicy < ApplicationPolicy
  def update?
    record_owner?
  end
end
