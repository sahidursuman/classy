class ReviewsController < ApplicationController
  before_action :review, :authorize_review

  def edit
    @edit_review_form = EditReviewForm.new review_attributes
  end

  def update
    @edit_review_form = EditReviewForm.new review_params.merge review: @review
    if @edit_review_form.save
      flash[:success] = t ".success"
      redirect_to branch_reviews_path @review.branch
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
    redirect_to branch_reviews_path @review.branch
  end

  private
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

  def review_params
    params.require(:edit_review_form).permit EditReviewForm::PARAMS
  end
end
