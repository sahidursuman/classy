class ApplicationPolicy
  attr_reader :user, :record

  def initialize user, record
    @user = user
    @record = record
  end

  private
  def member?
    user && (user.center_manager? || user.normal_user?)
  end

  def record_owner?
    user && user.id == record.user.id
  end

  def manager?
    user.try :is_manager?
  end

  def system_admin?
    user && user.is_system_admin?
  end
end
