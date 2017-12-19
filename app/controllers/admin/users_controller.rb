class Admin::UsersController < Admin::BaseController
  before_action :authenticate_root!, only: [:new, :create]

  def index
    @q = User.moderator_and_center_manager.ransack params[:q]
    @users = @q.result.page(params[:page]).per(Settings.admin.users.per_page).decorate
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".success"
      redirect_to admin_users_path
    else
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit User::USER_CREATE_PARAMS
  end
end
