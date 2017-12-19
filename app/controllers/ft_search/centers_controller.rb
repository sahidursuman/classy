class FtSearch::CentersController < ApplicationController
  def index
    @centers = Center.active.full_text_search(params[:center_name]).decorate
  end
end
