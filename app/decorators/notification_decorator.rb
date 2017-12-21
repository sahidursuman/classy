class NotificationDecorator < ApplicationDecorator
  extend Paginatable
  include Draper::LazyHelpers

  def url
    hash_value[:url]
  end

  def message
    hash_value[:message]
  end

  private
  def hash_value
    @hash_value ||= case action.to_sym
    when :new_review_verification
      {
        url: management_verification_reviews_path,
        message: "Trung tâm của bạn nhận được 1 yêu cầu xác thực đánh giá."
      }
    when :review_rejected
      {
        url: user_path(current_user),
        message: "Yêu cầu đánh giá của bạn bị từ chối, vui lòng kiểm tra lại thông tin xác thực."
      }
    when :review_verified
      {
        url: center_reviews_path(notifiable.center.route_params),
        message: "Đánh giá của bạn đã được xác thực từ phía trung tâm."
      }
    when :review_voted_up
      {
        url: center_reviews_path(notifiable.center.route_params),
        message: "Đánh giá của bạn nhận được 1 vote hữu ích."
      }
    when :review_voted_down
      {
        url: center_reviews_path(notifiable.center.route_params),
        message: "Đánh giá của bạn bị nhận 1 vote kém."
      }
    when :report_accepted
      {
        url: user_path(current_user),
        message: "Report của bạn đã được chấp nhận. Cảm ơn phản hồi của bạn!"
      }
    when :report_accepted
      {
        url: user_path(current_user),
        message: "Report của bạn không được chấp nhận. Cảm ơn phản hồi của bạn!"
      }
    end
  end
end
