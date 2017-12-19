class Branch::BaseController < ApplicationController
  before_action :branch

  private
  def branch
    center = Center.active.friendly_find params[:center_slug]
    @branch = center.active_branches.friendly_find params[:branch_slug]
  end
end
