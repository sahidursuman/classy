class Search::UrlMakersController < ApplicationController 
  def index
    pretty_search_path = CentersSearchUrlMakerService.new(search_params).perform
    redirect_to pretty_search_path
  end

  private
  def search_params
    params.require(:centers_search_form).permit CentersSearchForm::SEARCHABLE_ATTRIBUTES
  end
end
