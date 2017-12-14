class User::BaseController < ApplicationController
  before_action :user

  private
  def user
    @user = User.friendly_find params[:user_id]
  end
end
