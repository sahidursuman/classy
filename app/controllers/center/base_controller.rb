class Center::BaseController < ApplicationController
  layout "center"

  before_action :center, :load_meta_data

  private
  def center
    @center = Center.active.friendly_find(params[:center_slug]).decorate
  end

  def load_meta_data
    @center_avarage_rating = @center.reviews.verified.avarage_rating
  end
end
