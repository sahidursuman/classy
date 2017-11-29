class ReportDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  def display_report_target
    target = object.reportable
    case target.model_name
    when Center.name
      link_to t(Center.name), center_path(target.route_params)
    when Branch.name
      link_to t(Branch.name), branch_path(target.route_params)
    when Review.name
      link_to t(Review.name), branch_reviews_path(target.branch_route_params)
    else
      link_to t(Comment.name), branch_reviews_path(target.branch_route_params)
    end
  end

  def status_label_class
    object.in_review? ? "label label-info" : "label label-primary"
  end

  def display_response_message
    object.response_message.blank? ? t(".thank_you") : object.response_message
  end
end
