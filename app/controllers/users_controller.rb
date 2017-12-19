class UsersController < ApplicationController
  def show
    @user = User.friendly_find(params[:id]).decorate
  end
end
