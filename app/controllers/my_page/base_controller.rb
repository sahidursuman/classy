class MyPage::BaseController < ApplicationController
  before_action :user

  private
  def user
    @user = current_user.decorate
  end
end
