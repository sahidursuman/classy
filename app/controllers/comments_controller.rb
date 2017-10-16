class CommentsController < ApplicationController
  def index
    @review = Review.verified.find params[:review_id]
    @comments = @review.comments.earlier_created.includes(:user, :branch).decorate
  end
end
