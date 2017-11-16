class Search::CentersController < ApplicationController 
  def index
    @search_centers_form = SearchCentersForm.new
    @support = Supports::SearchCenters.new @search_centers_form
  end
end
