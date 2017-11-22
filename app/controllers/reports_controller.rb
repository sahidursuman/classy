class ReportsController < ApplicationController
  before_action :target, :authorize_create_report, only: [:new, :create]

  def new
    build_report
  end

  def create
    build_report
    if @report.save
      flash.now[:success] = t ".recorded"
    else
      flash.now[:failed] = t ".failed"
    end
  end

  private
  def report_params
    params.require(:report).permit Report::PARAMS
  end

  def reportable_params
    params.require(:report).permit Report::REPORTABLE_PARAMS
  end

  def target
    target_class = reportable_params[:reportable_type].constantize
    @target = target_class.find reportable_params[:reportable_id]
  end

  def authorize_create_report
    raise Pundit::NotAuthorizedError unless policy(@target).can_report?
  end

  def build_report
    @report = @target.reports.build report_params.merge user_id: current_user.id
  end
end
