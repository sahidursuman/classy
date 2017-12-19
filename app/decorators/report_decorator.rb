class ReportDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  decorates_association :user
  delegate :full_name, to: :user, prefix: :owner

  def display_report_target
    target = object.reportable
    case target.model_name
    when Center.name
      link_to t(Center.name), center_path(target.route_params), target: "_blank"
    when Review.name
      link_to t(Review.name), center_reviews_path(target.center_route_params), target: "_blank"
    else
      link_to t(Comment.name), center_reviews_path(target.review.center_route_params), target: "_blank"
    end
  end

  def status_label_class
    object.in_review? ? "label label-info" : "label label-primary"
  end

  def display_response_message
    object.response_message.blank? ? t(".thank_you") : object.response_message
  end

  def display_status
    I18n.t("admin.reports.report_filter." + report.status)
  end
end
