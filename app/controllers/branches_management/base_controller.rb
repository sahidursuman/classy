class BranchesManagement::BaseController < ApplicationController
  before_action :authorize_user

  layout "management"

  private
  def authorize_user
    raise Pundit::NotAuthorizedError unless current_user.try :branch_manager?
  end
end
