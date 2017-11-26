class Report < ApplicationRecord
  PARAMS = [:content]
  REPORTABLE_PARAMS = [:reportable_id, :reportable_type]
  ADMIN_REVIEW_PARAMS = [:response_message, :status]

  belongs_to :reportable, polymorphic: true
  belongs_to :user

  validates :content, presence: true, length: {minimum: Settings.validations.report.content.min_length,
    maximum: Settings.validations.report.content.max_length, allow_blank: true}
  validates :reportable_id, :reportable_type, presence: true
  validates :response_message, presence: true, length: {minimum: Settings.validations.report.response_message.min_length,
    maximum: Settings.validations.report.response_message.max_length, allow_blank: true}, on: :update
  validates :status, presence: true

  scope :recent_created, ->{order created_at: :desc}

  enum status: [:in_review, :accepted, :rejected]

  acts_as_paranoid
end
