class Management::BranchesController < Management::BaseController
  before_action :center
  before_action :branch, :authorize_edit_permission!, only: [:edit, :update]

  def index
    @q = current_user.managed_center.branches.ransack params[:q]
    @branches = @q.result.decorate
    @support = ::Supports::Center.new @center
  end

  def new
    @branch = Branch.new
    @support = Supports::Branch.new @branch
  end

  def create
    @branch = @center.branches.build branch_params.merge status: :active
    if @branch.save
      flash[:success] = t ".success"
      redirect_to management_branches_path
    else
      @support = Supports::Branch.new @branch
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  def edit
    @support = Supports::Branch.new @branch
  end

  def update
    if @branch.update_attributes branch_params
      flash[:success] = t ".success"
      redirect_to management_branches_path
    else
      @support = Supports::Branch.new @branch
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  private
  def branch
    @branch = Branch.find params[:id]
  end

  def authorize_edit_permission!
    authorize @branch
  end

  def branch_params
    params.require(:branch).permit Branch::ATTRIBUTES
  end
end
