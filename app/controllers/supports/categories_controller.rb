class Supports::CategoriesController < ApplicationController
  def index
    find_category
    @categories = if @category.present?
      @category.child_categories.pluck :name, params[:value_attribute]
    else
      []
    end
  end

  private 
  def find_category
    @category = if params[:value_attribute].to_sym == :id
      Category.find_by id: params[:findable_params]
    else
      Category.by_key_names params[:findable_params]
    end
  end
end
