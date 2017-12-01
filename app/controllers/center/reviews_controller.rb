class Center::ReviewsController < Center::BaseController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @q = displayable_reviews.ransack params[:q]
    @q.sorts = default_sorting_option if @q.sorts.empty?
    @reviews = @q.result.includes(:user, branch: :center).decorate
  end

  def new
    @review = @center.reviews.build
    @review.review_verifications.build
    @support = Supports::Review.new @review
  end

  def create
    @review = @center.reviews.build review_params.merge user_id: current_user.id
    if @review.save
      flash[:success] = t ".success"
      redirect_to center_reviews_path @center.route_params
    else
      flash.now[:failed] = t ".failed"
      @support = Supports::Review.new @review
      render :new
    end
  end

  private
  def authenticate_user!
    raise Pundit::NotAuthorizedError unless user_signed_in?
  end

  def review_params
    params.require(:review).permit Review::ATTRIBUTES_TO_CREATE
  end

  def displayable_reviews
    if user_signed_in?
      @center.reviews.verified.with_voted_type_by_user(current_user)
    else
      @center.reviews.verified
    end
  end

  def default_sorting_option
    Review::SORTING_OPTIONS.first[:value]
  end
end
