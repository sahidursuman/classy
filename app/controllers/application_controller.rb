class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def after_sign_in_path_for resource
    stored_location_for(resource) || path_after_sign_in
  end

  private
  def require_sign_in!
    return if user_signed_in?
    flash[:alert] = t "require_sign_in"
    store_location_for :user, request.referer
    respond_to do |format|
      format.js {render ajax_redirect_to(new_user_session_path)}
      format.html {redirect_to new_user_session_path}
    end
  end

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

  def path_after_sign_in
    case current_user.role.to_sym
    when :admin
      admin_root_path
    when :moderator
      root_path
    when :center_manager
      root_path
    when :normal_user
      root_path
    end
  end

  def ajax_redirect_to redirect_uri
    {js: "window.location.replace('#{redirect_uri}');"}
  end
end
