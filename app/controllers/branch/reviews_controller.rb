class Branch::ReviewsController < Branch::BaseController
  def index
    @q = displayable_reviews.ransack params[:q]
    @q.sorts = default_sorting_option if @q.sorts.empty?
    @reviews = @q.result.includes(:user).decorate
  end


  private
  def displayable_reviews
    if user_signed_in?
      @branch.reviews.verified.with_voted_type_by_user(current_user)
    else
      @branch.reviews.verified
    end
  end

  def default_sorting_option
    Review::SORTING_OPTIONS.first[:value]
  end
end
