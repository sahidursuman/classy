class Center::BranchesController < Center::BaseController
  def index
    @q = center.active_branches.ransack params[:q]
    @branch_groups = @q.result.order_name_asc.includes(:center, :city, :district).decorate
      .group_by{|branch| branch.city}.sort_by{|k, v| k.priority}.reverse
    @support = Supports::Center.new center
    impressionist @center
  end
end
