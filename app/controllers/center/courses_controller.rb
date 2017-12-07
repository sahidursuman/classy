class Center::CoursesController < Center::BaseController
  def index
    @courses = @center.courses.includes :course_category
  end
end
