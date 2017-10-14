class ReviewsController < ApplicationController
  before_action :branch
  before_action :authorize_user, only: [:new, :create]

  def index
    @reviews = branch.reviews.verified.recent_created.includes(:user).decorate
  end

  def new
    @create_review_form = CreateReviewForm.new
  end

  def create
    @create_review_form = CreateReviewForm.new review_params.merge user_id: current_user.id,
      branch_id: @branch.id
    if @create_review_form.save
      redirect_to branch_reviews_path(@branch), success: "Create review success"
    else
      render :new
    end
  end

  private
  def branch
    @branch = Branch.active.friendly_find params[:branch_id]
  end

  def review_params
    params.require(:create_review_form).permit CreateReviewForm::PARAMS
  end

  def authorize_user
    raise Pundit::NotAuthorizedError unless policy(@branch).can_review?
  end
end
