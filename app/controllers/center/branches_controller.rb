class Center::BranchesController < Center::BaseController
  def index
    @q = center.active_branches.ransack params[:q]
    @branches = @q.result.order_name_asc.includes(:center, :city, :district).decorate
    @support = Supports::Center.new center
  end
end
