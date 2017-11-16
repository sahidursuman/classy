class Supports::DistrictsController < ApplicationController
  def index
    @districts = if params[:findable_params].present?
      City.find_by(params[:value_attribute] => params[:findable_params]).districts
        .pluck :name, params[:value_attribute]
    else
      []
    end
  end
end
