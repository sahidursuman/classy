class ReportPolicy < ApplicationPolicy
  def destroy?
    record_owner?
  end
end
