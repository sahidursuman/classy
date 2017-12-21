class Admin::ReportsController < Admin::BaseController
  before_action :report, only: [:edit, :update]

  def index
    @q = Report.ransack params[:q]
    @reports = @q.result.recent_created.includes(:user, :reportable)
      .page(params[:page]).per(Settings.report.per_page).decorate
  end

  def edit
  end

  def update
    if @report.update_attributes report_params
      notify_user
      @report = @report.decorate
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] =  @report.errors.full_messages.to_sentence
    end
  end

  private
  def report_params
    params.require(:report).permit Report::ADMIN_REVIEW_PARAMS
  end

  def report
    @report = Report.find params[:id]
  end

  def notify_user
    action = @report.accepted? ? :report_accepted : :report_rejected
    @report.user.received_notifications.create notifiable: Comment.first, action: action
  end
end
