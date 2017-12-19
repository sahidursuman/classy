class Review::CommentsController < Review::BaseController
  before_action :require_sign_in!, only: [:new, :create]
  before_action :authorize_user, only: [:new, :create]

  def index
    @comment = build_comment.decorate if user_signed_in?
    @comments = @review.comments.earlier_created.includes(:user, :center).decorate
  end

  def new
    @comment = build_comment.decorate
    @comments = @review.comments.earlier_created.includes(:user, :center).decorate
  end


  def create
    @comment = build_comment
    @comment.assign_attributes comment_params.merge review: @review
    if @comment.save
      @comment = @comment.decorate
      @review = @review.reload.decorate
    else
      flash.now[:failed] = @comment.errors.full_messages.to_sentence
    end
  end

  private
  def comment_params
    params.require(:comment).permit Comment::PARAMS
  end

  def build_comment
    if current_user.try(:managed_center) == @review.center
      current_user.center_comments.build review: @review
    else
      current_user.user_comments.build
    end
  end

  def authorize_user
    raise Pundit::NotAuthorizedError unless policy(@review).can_comment?
  end
end
