class MyPage::PasswordsController < MyPage::BaseController
  def edit
  end

  def update
    if @user.update_with_password user_params
      bypass_sign_in(@user)
      flash[:success] = t ".updated"
      redirect_to user_path(@user)
    else
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit User::PASSWORD_PARAMS
  end
end
