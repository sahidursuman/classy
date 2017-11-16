class Search::CentersController < ApplicationController 
  def index
    search_params = ParseUrlToSearchParamsService.new(params).perform
    @centers_search_form = CentersSearchForm.new search_params
    @support = Supports::CentersSearchForm.new @centers_search_form
  end
end
