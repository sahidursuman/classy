class Management::Verification::ReviewsController < Management::BaseController
  before_action :center

  def index
    @q = @center.reviews.ransack params[:q]
    @reviews = @q.result.recent_created.page(params[:page])
      .per(Settings.review_verification.per_page).includes :branch
    @support = Supports::ReviewVerification.new @center
  end

  def update
    @review = Review.find params[:id]
    if @review.update_attributes review_verification_params
      create_notification
      flash[:success] = t ".success"
    else
      flash[:failed] = t ".failed"
    end
    redirect_back fallback_location: management_verification_reviews_path
  end

  private
  def review_verification_params
    params.permit Review::PARAMS_VERIFY
  end

  def create_notification
    action = @review.verified? ? :review_verified : :review_rejected
    Notification.create notifiable: @review, recipient_id: @review.user_id, action: action,
      user: current_user
  end
end
