class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!, :set_locale

  layout "admin"

  private
  def authenticate_admin!
    raise Pundit::NotAuthorizedError unless current_user.try :is_system_admin?
  end

  def authenticate_root!
    raise Pundit::NotAuthorizedError unless current_user.try :root?
  end

  def set_locale
    I18n.locale = :en
  end
end
