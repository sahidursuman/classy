class Management::BaseController < ApplicationController
  before_action :authorize_manager!

  layout "management"

  private
  def authorize_manager!
    raise Pundit::NotAuthorizedError unless current_user.try :is_manager?
  end
end
