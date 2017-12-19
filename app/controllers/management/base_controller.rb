class Management::BaseController < ApplicationController
  before_action :authenticate_center_manager!

  layout "management"

  private
  def authenticate_center_manager!
    raise Pundit::NotAuthorizedError unless current_user.try :center_manager?
  end

  def center
    @center = current_user.managed_center
  end
end
