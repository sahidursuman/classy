class Supports::DistrictsController < ApplicationController
  def index
    @districts = if params[:object].present?
      City.find(params[:object]).districts.pluck :name, :id
    else
      []
    end
  end
end
