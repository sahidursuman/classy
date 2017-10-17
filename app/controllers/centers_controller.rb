class CentersController < ApplicationController
  def show
    @center = Center.active.friendly_find params[:id]
    @branches = @center.active_branches
  end
end
