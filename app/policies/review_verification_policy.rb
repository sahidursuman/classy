class ReviewVerificationPolicy < ApplicationPolicy
  def can_verify?
    record.forwarded? && user && user.branches_under_management.try(:include?, record.branch)
  end
end
