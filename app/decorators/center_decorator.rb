class CenterDecorator < ApplicationDecorator
  extend Paginatable
  include Draper::LazyHelpers

  def city_names
    cities.pluck(:name).join ", "
  end

  def category_details
    center_category.name + ": " + course_categories.pluck(:name).join(", ")
  end

  def course_category_names
    course_categories.pluck(:name).join ", "
  end

  def location
    if branches.size == 1
      branches.first.full_address
    else
      t ".number_of_branch_in_cities", number_of_branch: branches.size, cities: city_names
    end
  end
end
