class Management::BaseController < ApplicationController
  before_action :authenticate_manager!

  layout "management"

  private
  def authenticate_manager!
    raise Pundit::NotAuthorizedError unless current_user.try :is_manager?
  end

  def authenticate_center_manager!
    raise Pundit::NotAuthorizedError unless current_user.center_manager?
  end

  def center
    @center = current_user.managed_center
  end
end
