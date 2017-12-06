class NotifyNewReviewVerificationJob < ApplicationJob
  def perform review
    Notification::NotifyCenterManagersService.new(review.center, review.center, review,
      :new_review_verification, review.user).perform
  end
end
