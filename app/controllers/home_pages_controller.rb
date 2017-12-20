class HomePagesController < ApplicationController
  layout "full_page"

  def show
    render template: "home_pages/#{params[:page]}"
  end
  def index
    @current_user = current_user.try :decorate
  end
end
