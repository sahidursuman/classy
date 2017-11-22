class Report < ApplicationRecord
  PARAMS = [:content]
  REPORTABLE_PARAMS = [:reportable_id, :reportable_type]

  belongs_to :reportable, polymorphic: true
  belongs_to :user

  validates :content, presence: true, length: {minimum: Settings.validations.report.content.min_length,
    maximum: Settings.validations.report.content.max_length, allow_blank: true}
  validates :reportable_id, :reportable_type, presence: true

  scope :recent_created, ->{order created_at: :desc}

  enum status: [:in_review, :reviewed]

  acts_as_paranoid
end
