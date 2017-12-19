module ReportHelper
  def report_status_options
    Report::statuses.map {|key, value| [I18n.t("admin.reports.report_filter." + key), value]}
  end

  def report_target_options
    Settings.report.target_models.map {|value| [I18n.t("admin.reports.report_filter." + value), value]}
  end
end
