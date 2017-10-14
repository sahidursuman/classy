class CentersController < ApplicationController
  def show
    @center = Center.active.friendly_find params[:id]
  end
end
