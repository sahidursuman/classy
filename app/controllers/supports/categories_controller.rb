class Supports::CategoriesController < ApplicationController
  def index
    find_category
    @categories = if @category.present?
      @category.child_categories.priority_desc.pluck :name, params[:value_attribute]
    else
      []
    end
  end

  private 
  def find_category
    @category = if params[:findable_params].present?
      Category.find_by params[:value_attribute] => params[:findable_params]
    end
  end
end
