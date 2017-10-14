class ApplicationPolicy
  attr_reader :user, :record

  def initialize user, record
    @user = user
    @record = record
  end

  private
  def member?
    user && (user.center_manager? || user.branch_manager? || user.normal_user?)
  end
end
