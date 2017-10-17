class HomePagesController < ApplicationController
  def index
    @current_user = current_user.try :decorate
  end
end
