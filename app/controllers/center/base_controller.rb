class Center::BaseController < ApplicationController
  before_action :center
  
  private
  def center
    @center = Center.active.friendly_find params[:center_slug]
  end
end
