class Search::CentersController < ApplicationController
  def index
    search_params = ActionController::Parameters.new ParseUrlToSearchParamsService.new(params)
      .perform
    @search_form = CenterSearchForm.new search_params.permit!
    @search = Supports::CenterSearch.new search_params, params[:page]
  end
end
