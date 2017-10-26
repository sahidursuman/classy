class CenterManagement::BranchesController < CenterManagement::BaseController
  include Wicked::Wizard
  include SetupWizard

  before_action :setup_wizard, only: :create

  steps :start, :preview, :finish

  def index
    @q = current_user.managed_center.branches.ransack params[:q]
    @branches = @q.result
    @support = ::Supports::Center.new current_user.managed_center
  end

  def new
    @branch = @center.branches.build
    branch_support
  end

  def create
    @branch = @center.branches.build branch_params.merge status: :active
    wicked_step
  end

  private
  def branch_params
    params.require(:branch).permit Branch::ATTRIBUTES
  end

  def wicked_step
    case step
    when :start
      branch_support
      render :new
    when :preview
      preview_step
    when :finish
      finish_step
    end
  end

  def branch_support
    @support = Supports::Branch.new @branch
  end

  def preview_step
    if @branch.valid?
      render_wizard
    else
      branch_support
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  def finish_step
    if @branch.save
      flash[:success] = t ".success"
      redirect_to center_management_branches_path
    else
      branch_support
      flash.now[:failed] = t ".failed"
      render :new
    end
  end
end
