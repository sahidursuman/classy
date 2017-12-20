class UsersController < ApplicationController
  def show
    @user = User.friendly_find(params[:id]).decorate
    @reviews = displayable_reviews.includes(:user, :center).recent_created.decorate
  end

  private
  def displayable_reviews
    if user_signed_in?
      @user.reviews.verified.with_voted_type_by_user(current_user)
    else
      @user.reviews.verified
    end
  end
end
