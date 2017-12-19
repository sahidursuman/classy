class Management::CentersController < Management::BaseController
  before_action :center

  def edit
    @support = Supports::Center.new @center
  end

  def update
    @center.assign_attributes center_params
    if @center.save
      flash[:success] = t ".success"
      redirect_to center_path(@center.route_params)
    else
      @support = Supports::Center.new @center
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  private
  def center_params
    params.require(:center).permit Center::ATTRIBUTES
  end
end
