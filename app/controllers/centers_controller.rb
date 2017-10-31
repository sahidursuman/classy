class CentersController < ApplicationController
  def show
    @center = Center.active.friendly_find params[:center_slug]
    @branches = @center.active_branches.decorate
  end
end
