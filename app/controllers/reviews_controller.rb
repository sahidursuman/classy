class ReviewsController < ApplicationController
  before_action :review, :authorize_user, only: [:edit, :update, :destroy]

  def edit
    @support = Supports::Review.new @review
  end

  def update
    @review.assign_attributes review_params
    request_re_verification
    if @review.save
      flash[:success] = t ".success"
    else
      @support = Supports::Review.new @review
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t ".success"
    else
      flash[:failed] = t ".failed"
    end
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  private
  def review
    @review = Review.find params[:id]
  end

  def authorize_user
    authorize @review
  end

  def review_params
    attributes_to_permit = if @review.verified?
      Review::ATTRIBUTES_TO_PERSIST_CONTENT
    else
      Review::ATTRIBUTES_TO_PERSIST_FULL
    end
    params.require(:review).permit attributes_to_permit
  end

  def request_re_verification
    if @review.rejected? && (@review.email_verifiable_changed? || @review.phone_number_verifiable_changed?)
      @review.assign_attributes status: :unverified
    end
  end
end
