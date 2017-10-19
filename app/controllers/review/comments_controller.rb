class Review::CommentsController < Review::BaseController
  def index
    @comments = @review.comments.earlier_created.includes(:user, :branch).decorate
  end
end
