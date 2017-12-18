class MyPage::BaseController < ApplicationController
  before_action :require_sign_in!, :user

  private
  def user
    @user = current_user.decorate
  end
end
