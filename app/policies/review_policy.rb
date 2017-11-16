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

  def can_report?
    user && !reported?
  end

  private
  def reported?
    Report.exists? user_id: user, reportable: record
  end
end
