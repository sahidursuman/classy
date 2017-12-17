class Review::CommentsController < Review::BaseController
  before_action :authorize_user, only: [:new, :create]

  def new
    @new_comment = Comment.new
  end

  def index
    @comments = @review.comments.earlier_created.includes(:user, :center).decorate
  end

  def create
    @comment = build_comment.decorate
    if @comment.save
      @review = @review.reload.decorate
    else
      flash.now[:failed] = @comment.errors.full_messages.to_sentence
    end
  end

  private
  def comment_params
    params.permit Comment::PARAMS
  end

  def build_comment
    if current_user.manage_branch? @review.branch
      current_user.center_comments.build comment_params.merge branch: review.branch, review: review
    else
      current_user.user_comments.build comment_params.merge review: review
    end
  end

  def authorize_user
    raise Pundit::NotAuthorizedError unless policy(@review).can_comment?
  end
end
