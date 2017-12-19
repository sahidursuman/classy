class CentersController < ApplicationController
  layout "center"

  def show
    @center = Center.active.friendly_find(params[:center_slug]).decorate
    @center_avarage_rating = @center.reviews.verified.avarage_rating
    impressionist @center
  end
end
