class MyPage::BaseController < ApplicationController
  before_action :require_sign_in!, :user

  layout "my_page"

  private
  def user
    @user = current_user.decorate
  end
end
