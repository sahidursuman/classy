class Review::VotesController < Review::BaseController
  before_action :require_sign_in!
  before_action :authorize_user, only: :create

  def create
    @vote_form = VoteForm.new vote_params.merge user: current_user, review: @review
    if @vote_form.save
      @review = @review.reload.decorate
      @review.voted_type = Vote::vote_types[@vote_form.vote_type]
      create_notification
    else
      flash.now[:failed] = t ".failed"
    end
  end

  def destroy
    @vote = Vote.find_by user: current_user, review: @review
    if @vote.really_destroy!
      @review = @review.reload.decorate
    else
      flash.now[:failed] = t ".failed"
    end
  end

  private
  def vote_params
    params.permit VoteForm::PARAMS
  end

  def authorize_user
    raise Pundit::NotAuthorizedError unless policy(@review).can_vote?
  end

  def create_notification
    action = @vote_form.vote_type == :up.to_s ? :review_voted_up : :review_voted_down
    Notification.create notifiable: @review, recipient_id: @review.user_id, action: action,
      user: current_user
  end
end
