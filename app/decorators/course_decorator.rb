class CourseDecorator < ApplicationDecorator
  delegate_all

  def tmp_course_sub_category_list
    CourseSubCategory.by_ids(tmp_course_sub_category_ids).pluck(:name).join ", "
  end
end
