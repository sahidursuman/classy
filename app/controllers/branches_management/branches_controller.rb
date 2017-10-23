class BranchesManagement::BranchesController < BranchesManagement::BaseController
  def index
    @q = current_user.managed_branches.ransack params[:q]
    @branches = @q.result
    @support = ::Supports::Center.new current_user.working_center
  end
end
