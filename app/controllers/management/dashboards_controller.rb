class Management::DashboardsController < Management::BaseController
  before_action :center

  def show
    @support = Supports::CenterDashboard.new @center
  end
end
