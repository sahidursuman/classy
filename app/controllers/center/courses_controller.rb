class Center::CoursesController < Center::BaseController
  def index
    @courses = @center.courses.includes :course_category
  end

  def show
    @course = @center.courses.friendly_find params[:course_slug]
  end
end
