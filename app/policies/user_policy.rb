class UserPolicy < ApplicationPolicy
  def update?
    record_owner?
  end
end
