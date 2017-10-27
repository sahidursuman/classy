class CenterManagement::BaseController < ApplicationController
  before_action :authorize_center_management!

  layout "management"

  private
  def authorize_center_management!
    raise Pundit::NotAuthorizedError unless current_user.try :center_manager?
  end

  def center
    @center = current_user.managed_center
  end
end
