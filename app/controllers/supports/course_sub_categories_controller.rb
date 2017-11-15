class Supports::CourseSubCategoriesController < ApplicationController
  def index 
    @course_sub_categories = if params[:object].present?
      CourseCategory.find(params[:object]).course_sub_categories.pluck :name, :id
    else
      []
    end
  end
end
