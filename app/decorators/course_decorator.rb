class CourseDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  def tmp_course_sub_category_list
    CourseSubCategory.by_ids(tmp_course_sub_category_ids).pluck(:name).join ", "
  end

  def full_duration
    [(sessions.present? ? "#{sessions} buổi" : nil),
      (duration.present? ? "#{number_with_precision duration, strip_insignificant_zeros: true} tháng" : nil)].compact.join "/"
  end

  def full_categories
    [course_category.name, course_sub_categories.pluck(:name).join(", ").presence].compact
      .join ": "
  end
end
