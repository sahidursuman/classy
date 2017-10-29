class CommentsController < ApplicationController
  before_action :comment, :authorize_comment, only: :destroy

  def destroy
    if @comment.destroy
      @review = @comment.review.reload.decorate
    else
      flash.now[:failed] = t ".failed"
    end
  end

  private
  def authorize_comment
    authorize @comment
  end

  def comment
    @comment = Comment.find params[:id]
  end
end
