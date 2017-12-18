class MyPage::NotificationsController < MyPage::BaseController
  def index
    respond_to do |format|
      format.js do
        @notifications = @user.received_notifications.recent_created.limit(10).decorate
      end
      format.html do
        @notifications = @user.received_notifications.recent_created.page(params[:page]).decorate
      end
    end
  end
end
