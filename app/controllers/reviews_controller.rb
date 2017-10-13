class ReviewsController < ApplicationController
  def index
    branch = Branch.active.friendly_find params[:branch_id]
    @reviews = branch.reviews.verified.recent_created.includes(:user).decorate
  end
end
