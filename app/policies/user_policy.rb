class UserPolicy < ApplicationPolicy
  def update?
    record_owner?
  end

  def create_user?
    user && user.root?
  end
end
