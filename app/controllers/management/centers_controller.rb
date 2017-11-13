class Management::CentersController < Management::BaseController
  include Wicked::Wizard
  include SetupWizard

  before_action :authenticate_center_manager!, :center
  before_action :setup_wizard, only: :update

  steps :start, :preview, :finish

  def edit
    center_support
  end

  def update
    @center.assign_attributes center_params
    wicked_steps
  end

  private
  def center_support
    @support = Supports::Center.new @center
  end

  def center_params
    params.require(:center).permit Center::ATTRIBUTES
  end

  def wicked_steps
    case step
    when :start
      center_support
      render :edit
    when :preview
      preview_step
    when :finish
      finish_step
    end
  end

  def preview_step
    if @center.valid?
      render_wizard
    else
      flash.now[:failed] = t ".failed"
      center_support
      render :edit
    end
  end

  def finish_step
    if @center.save 
      flash[:success] = t ".success"
      redirect_to root_path
    else 
      flash.now[:failed] = t ".failed"
      center_support
      render :edit
    end
  end
end
