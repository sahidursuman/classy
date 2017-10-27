class CenterManagement::BranchesController < CenterManagement::BaseController
  include Wicked::Wizard
  include SetupWizard

  before_action :setup_wizard, only: [:create, :update]
  before_action :center, only: [:index, :new, :create]
  before_action :branch, :authorize_edit_permission!, only: [:edit, :update]

  steps :start, :preview, :finish

  def index
    @q = current_user.managed_center.branches.ransack params[:q]
    @branches = @q.result
    @support = ::Supports::Center.new @center
  end

  def new
    @branch = @center.branches.build
    branch_support
  end

  def create
    @branch = @center.branches.build branch_params.merge status: :active
    wicked_step
  end

  def edit
    branch_support
  end

  def update
    @branch.assign_attributes branch_params
    wicked_step
  end

  private
  def branch
    @branch = Branch.friendly_find params[:id]
  end

  def authorize_edit_permission!
    authorize @branch
  end

  def branch_params
    params.require(:branch).permit Branch::ATTRIBUTES
  end

  def wicked_step
    case step
    when :start
      branch_support
      render_start_step
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
      render_start_step
    end
  end

  def finish_step
    if @branch.save
      flash[:success] = t ".success"
      redirect_to center_management_branches_path
    else
      branch_support
      flash.now[:failed] = t ".failed"
      render_start_step
    end
  end

  def render_start_step
    if @branch.new_record?
      render :new
    else
      render :edit
    end
  end
end
