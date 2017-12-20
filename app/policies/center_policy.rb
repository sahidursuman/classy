class CenterPolicy < ApplicationPolicy
  def can_edit?
    can_modify?
  end

  def can_report?
    member? && (user.working_center != record)
  end

  def can_review?
    if user.normal_user?
      !user.reviews.where("created_at > '#{1.month.ago}'").exists?(center: record)
    elsif user.center_manager?
      user.managed_center != record
    else
      false
    end
  end

  private
  def can_modify?
    user && user.center_manager? && (user.working_center == record)
  end
end
