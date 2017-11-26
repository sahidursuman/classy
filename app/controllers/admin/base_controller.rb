class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  layout "admin"

  private
  def authenticate_admin!
    raise Pundit::NotAuthorizedError unless current_user.try :is_system_admin?
  end
end
