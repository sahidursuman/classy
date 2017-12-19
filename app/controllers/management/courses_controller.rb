class Management::CoursesController < Management::BaseController
  before_action :center
  before_action :course, :authorize_modify_course!, only: [:edit, :update]

  def index
    @courses = @center.courses.includes(:course_category).decorate
  end

  def new
    @course = @center.courses.build
    support_for_course
  end

  def create
    custome_category_params
    @course = @center.courses.build course_params
    if @course.save
      flash[:success] = t ".success"
      redirect_to management_courses_path
    else
      support_for_course
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  def edit
    @course.tmp_course_sub_category_ids = @course.course_sub_category_ids
    support_for_course
  end

  def update
    custome_category_params
    if @course.update_attributes course_params
     flash[:success] = t ".success"
     redirect_to management_courses_path
    else
      support_for_course
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  private
  def course_params
    @course_params ||= params.require(:course).permit Course::ATTRIBUTES
  end

  def course
    @course = Course.find params[:id]
  end

  def authorize_modify_course!
    authorize @course
  end

  def custome_category_params
    course_params[:course_sub_category_ids] = course_params.delete :tmp_course_sub_category_ids
  end

  def support_for_course
    @support = Supports::Course.new @course
  end
end
