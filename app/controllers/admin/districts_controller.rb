class Admin::DistrictsController < Admin::BaseController
  before_action :authenticate_root!

  def index
    @districts = District.order(city_id: :asc).priority_desc.page(params[:page]).per(20)
      .includes :city
  end
end
