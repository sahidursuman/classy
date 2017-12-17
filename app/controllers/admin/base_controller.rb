class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  layout "admin"

  private
  def authenticate_admin!
    raise Pundit::NotAuthorized unless current_user.try(:is_admin?)
  end
end
