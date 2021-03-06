class Search::CentersController < ApplicationController
  def index
    @search_form = CenterSearchForm.new center_search_params
    @search = Supports::CenterSearch.new @search_form, params[:page]
  end

  private
  def center_search_params
    params.require(:center_search_form).permit CenterSearchForm::SEARCHABLE_ATTRIBUTES
  rescue
    nil
  end
end
