class Management::BranchesController < Management::BaseController
  include Wicked::Wizard
  include SetupWizard

  before_action :setup_wizard, only: [:create, :update]
  before_action :branch, :authorize_edit_permission!, only: [:edit, :update]

  steps :start, :preview, :finish

  def index
    @q = current_user.managed_center.branches.ransack params[:q]
    @branches = @q.result.decorate
    @support = ::Supports::Center.new center
  end

  def new
    @branch = Branch.new
    branch_support
  end

  def create
    @branch = center.branches.build branch_params.merge status: :active
    wicked_steps
  end

  def edit
    branch_support
  end

  def update
    @branch.assign_attributes branch_params
    wicked_steps
  end

  private
  def center
    current_user.working_center
  end

  def branch
    @branch = Branch.find params[:id]
  end

  def authorize_edit_permission!
    authorize @branch
  end

  def branch_params
    params.require(:branch).permit Branch::ATTRIBUTES
  end

  def wicked_steps
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
      @branch = @branch.decorate
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
      redirect_to management_branches_path
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
