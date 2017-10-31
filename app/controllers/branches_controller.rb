class BranchesController < ApplicationController
  def show
    center = Center.active.friendly_find params[:center_slug]
    @branch = center.active_branches.friendly_find(params[:branch_slug]).decorate
  end
end
