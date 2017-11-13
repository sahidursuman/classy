class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private
  def user_not_authorized
    flash[:alert] = t "not_authorized"
    redirect_back fallback_location: root_path
  end

  def not_found
    if request.xhr?
      render js: "$('.container').load('/404.html')", status: 404
    else
      render file: "public/404.html", status: 404, layout: false
    end
  end
end
