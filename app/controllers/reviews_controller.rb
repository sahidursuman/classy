class ReviewsController < ApplicationController
  before_action :branch, :authorize_create_review, only: [:new, :create]
  before_action :review, :authorize_review, only: [:edit, :update, :destroy]

  def new
    @create_review_form = CreateReviewForm.new
  end

  def create
    @create_review_form = CreateReviewForm.new create_review_params.merge user: current_user,
      branch: @branch
    if @create_review_form.save
      flash[:success] = t ".success"
      redirect_to branch_reviews_path @branch.route_params
    else
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  def edit
    @edit_review_form = EditReviewForm.new review_attributes
  end

  def update
    @edit_review_form = EditReviewForm.new edit_review_params.merge review: @review
    if @edit_review_form.save
      flash[:success] = t ".success"
      redirect_to branch_reviews_path @review.branch.route_params
    else
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t ".success"
    else
      flash[:failed] = t ".failed"
    end
    redirect_to branch_reviews_path @review.branch.route_params
  end

  private
  def branch
    @branch = Branch.active.find params[:branch_id]
  end

  def authorize_create_review
    raise Pundit::NotAuthorizedError unless policy(@branch).can_review?
  end

  def create_review_params
    params.require(:create_review_form).permit CreateReviewForm::PARAMS
  end

  def review
    @review = Review.find params[:id]
  end

  def authorize_review
    authorize @review
  end

  def review_attributes
    EditReviewForm::PARAMS.inject({}) do |params, attribute|
      params.merge attribute => @review.send(attribute)
    end
  end

  def edit_review_params
    params.require(:edit_review_form).permit EditReviewForm::PARAMS
  end
end
