class CoursePolicy < ApplicationPolicy 
  def edit?
    can_modify?
  end

  def update?
    can_modify?
  end

  private
  def can_modify?
    user && user.center_manager? && user.managed_center.id == record.center_id
  end
end
