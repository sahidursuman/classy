class CenterManagement::BranchesController < CenterManagement::BaseController
  def index
    @q = current_user.managed_center.branches.ransack params[:q]
    @branches = @q.result
    @support = ::Supports::Center.new current_user.managed_center
  end
end
