class Review::BaseController < ApplicationController
  before_action :review

  private
  def review
    @review = Review.verified.find params[:review_id]
  end
end
