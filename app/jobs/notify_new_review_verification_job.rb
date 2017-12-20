class NotifyNewReviewVerificationJob < ApplicationJob
  def perform review
    Notification::NotifyCenterManagersService.new(review.center, review,
      :new_review_verification).perform
  end
end
