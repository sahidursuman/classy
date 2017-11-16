class Report < ApplicationRecord
  belongs_to :reportable, polymorphic: true
  belongs_to :user

  PARAMS = [:content]
  REPORTABLE_PARAMS = [:reportable_id, :reportable_type]

  validates :content, presence: true, length: {minimum: Settings.validations.report.content.min_length,
    maximum: Settings.validations.report.content.max_length, allow_blank: true}
  validates :reportable_id, :reportable_type, presence: true

  enum status: [:forwarded, :verified, :rejected]
end
