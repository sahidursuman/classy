class MyPage::ReportsController < MyPage::BaseController
  before_action :report, :authorize_report, only: :destroy

  def index
    @q = current_user.reports.ransack params[:q]
    @reports = @q.result.recent_created.decorate
  end

  def destroy
    if @report.destroy
      flash.now[:success] = t ".deleted"
    else
      flash.now[:failed] = t ".failed"
    end
  end

  private
  def report
    @report = Report.find params[:id]
  end

  def authorize_report
    authorize @report
  end
end
