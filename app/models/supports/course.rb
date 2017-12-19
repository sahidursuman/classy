class Supports::Course
  attr_reader :course

  def initialize course
    @course = course
  end

  def course_category_options
    @course_category_options ||= course.center.center_category.course_categories
      .priority_desc.pluck :name, :id
  end

  def course_sub_category_options 
    @course_sub_category_options ||= if course.course_category.present?
      course.course_category.course_sub_categories.priority_desc.pluck :name, :id
    else
      []
    end
  end
end
