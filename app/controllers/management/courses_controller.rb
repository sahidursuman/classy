class Management::CoursesController < Management::BaseController
  include Wicked::Wizard
  include SetupWizard
  
  before_action :authenticate_center_manager!, :center
  before_action :setup_wizard, only: :create

  steps :start, :preview, :finish

  def new
    @course = @center.courses.build
    support_for_course
  end

  def create
    @course = @center.courses.build course_params
    wicked_steps
  end

  private
  def course_params
    params.require(:course).permit Course::ATTRIBUTES
  end

  def wicked_steps
    case step
    when :start
      support_for_course
      render_start_step
    when :preview
      preview_step
    when :finish
      finish_step
    end
  end

  def preview_step
    if @course.valid?
      @course = @course.decorate
      render_wizard
    else
      support_for_course
      flash.now[:failed] = t ".failed"
      render_start_step
    end
  end

  def finish_step
    if @course.save
      flash[:success] = t ".success"
      redirect_to root_path
    else
      support_for_course
      flash.now[:failed] = t ".failed"
      render_start_step
    end
  end

  def render_start_step
    if @course.new_record?
      render :new
    else
      render :edit
    end
  end

  def support_for_course
    @support = Supports::Course.new @course
  end
end
