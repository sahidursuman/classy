class Center::BranchesController < Center::BaseController 
  def index
    @q = center.active_branches.ransack params[:q]
    @branches = @q.result.decorate
    @support = Supports::Center.new center
  end
end
