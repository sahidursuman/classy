class Management::BaseController < ApplicationController
  before_action :authorize_user

  layout "management"

  private
  def authorize_user
    unless current_user.try(:branch_manager?) || current_user.try(:center_manager?)
      raise Pundit::NotAuthorizedError
    end
  end
end
