class Management::BaseController < ApplicationController
  before_action :authorize_user

  layout "management"

  private
  def authorize_user
    unless current_user && current_user.branch_manager? || current_user.center_manager?
      redirect_to root_path, alert: t("not_authorized")
    end
  end
end
