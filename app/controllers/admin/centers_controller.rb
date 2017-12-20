class Admin::CentersController < Admin::BaseController
  def index
    @centers = Center.all.page(params[:page]).per(Settings.admin.centers.per_page)
      .includes :center_category
  end

  def new
    @center = Center.new
    @support = Supports::Center.new @center
  end

  def create
    @center = Center.new center_params.merge status: :active
    if @center.save
      flash[:success] = t ".success"
      redirect_to admin_centers_path
    else
      @support = Supports::Center.new @center
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  private
  def center_params
    params.require(:center).permit Center::ADMIN_PERSIT_PARAMS
  end
end
