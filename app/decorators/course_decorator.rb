class CourseDecorator < ApplicationDecorator
  delegate_all

  def category_list
    categories.map(&:name).join ", "
  end
end
