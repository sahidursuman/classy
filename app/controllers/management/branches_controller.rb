class Management::BranchesController < Management::BaseController
  def index
    @q = current_user.branches_under_management.ransack params[:q]
    @branches = @q.result
    @support = ::Supports::Center.new current_user.working_center
  end
end
