class MyPage::AccountsController < MyPage::BaseController
  def edit
  end

  def update
    if @user.update_with_password user_params
      flash[:success] = t ".updated"
      redirect_to user_path(@user)
    else
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit User::ACCOUNT_INFORMATION_PARAMS
  end
end
