class FtSearch::CentersController < ApplicationController
  def index
    @centers = Center.active.full_text_search(params[:center_name]).page(params[:page])
      .per(5).decorate
  end
end
