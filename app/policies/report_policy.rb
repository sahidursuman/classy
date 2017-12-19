class ReportPolicy < ApplicationPolicy
  def destroy?
    record_owner?
  end

  def can_review?
    record.in_review?
  end
end
