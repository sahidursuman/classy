class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :creatable, polymorphic: true
  belongs_to :recipient, class_name: User.name, foreign_key: :recipient_id
  belongs_to :user

  enum action: [:new_review_verification]
end
