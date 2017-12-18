class Center::ReviewsController < Center::BaseController
  before_action :require_sign_in!, only: [:new, :create]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @q = displayable_reviews.ransack params[:q]
    @q.order_by ||= Review::SORT_OPTIONS.first
    @reviews = @q.result.page(params[:page]).per(Settings.review.per_page).includes(:user).decorate
    @support = Supports::CenterReview.new @center, params[:q]
  end

  def new
    @review = @center.reviews.build
    @support = Supports::Review.new @review
  end

  def create
    @review = @center.reviews.build review_params.merge user_id: current_user.id
    if @review.save
      flash.now[:success] = t ".success"
    else
      @support = Supports::Review.new @review
    end
  end

  private
  def authenticate_user!
    raise Pundit::NotAuthorizedError unless user_signed_in?
  end

  def review_params
    params.require(:review).permit Review::ATTRIBUTES_TO_PERSIST_FULL
  end

  def displayable_reviews
    if user_signed_in?
      @center.reviews.verified.with_voted_type_by_user(current_user)
    else
      @center.reviews.verified
    end
  end
end
