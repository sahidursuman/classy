class Supports::Course
  attr_reader :course

  def initialize course
    @course = course
  end

  def course_category_options
    @course_category_options ||= course.center.center_category.course_big_categories
      .includes(:course_small_categories).inject([]) do |options, big_category|
      options.append([big_category.name, big_category.id]) + 
        big_category.course_small_categories.map{|category| [category.name, category.id]}
    end
  end
end
