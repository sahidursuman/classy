class CommentsController < ApplicationController
  before_action :comment, :authorize_comment

  def edit
  end

  def update
    if @comment.update_attributes comment_params
      @comment = @comment.decorate
    else
      flash.now[:failed] = @comment.errors.full_messages.to_sentence
    end
  end

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

  def comment_params
    params.permit Comment::PARAMS
  end
end
