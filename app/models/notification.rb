class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :creatable, polymorphic: true, optional: true
  belongs_to :recipient, class_name: User.name, foreign_key: :recipient_id
  belongs_to :user

  after_create :relay_notification

  scope :unread, ->{where is_read: false}
  scope :recent_created, ->{order created_at: :desc}

  enum action: [:new_review_verification, :review_rejected, :review_verified,
    :review_voted_up, :review_voted_down]

  private
  def relay_notification
    NotificationRelayJob.perform_later self
  end
end
