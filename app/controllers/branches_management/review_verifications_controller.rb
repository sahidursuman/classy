class BranchesManagement::ReviewVerificationsController < BranchesManagement::BaseController
  before_action :review_verification, :authorize_verification, only: :update

  def index
    branches = current_user.managed_branches
    @q = ReviewVerification.by_branch_ids(branches.pluck :id).ransack params[:q]
    @review_verifications = @q.result.recent_created.includes(:branch)
      .page(params[:page]).per Settings.review_verification.per_page
    @support = Supports::ReviewVerification.new branches
  end

  def update
    if @review_verification.update_attributes review_verification_params
      flash[:success] = t ".success"
    else
      flash[:failed] = t ".failed"
    end
    redirect_back fallback_location: branches_management_review_verifications_path
  end

  private
  def review_verification
    @review_verification = ReviewVerification.find params[:id]
  end

  def authorize_verification
    raise Pundit::NotAuthorizedError unless policy(@review_verification).can_verify?
  end

  def review_verification_params
    params.permit ReviewVerification::PARAMS_VERIFY
  end
end
