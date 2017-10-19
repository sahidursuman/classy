class BranchesController < ApplicationController
  def index
    center = Center.active.friendly_find params[:center_id]
    @q = center.active_branches.ransack params[:q]
    @branches = @q.result
    @support = Supports::Center.new center
  end

  def show
    @branch = Branch.active.friendly_find params[:id]
  end
end
