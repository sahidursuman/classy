class Center::CoursesController < Center::BaseController
  def index
    @courses = @center.courses.includes :course_category
    impressionist @center
  end

  def show
    @course = @center.courses.friendly_find params[:course_slug]
    impressionist @center
  end
end
