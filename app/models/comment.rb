class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  belongs_to :branch, optional: true

  scope :earlier_created, ->{order created_at: :asc}

  acts_as_paranoid

  counter_culture :review

  PARAMS = [:content]

  validates :content, presence: true, length: {minimum: Settings.validations.comment.content.min_length,
    maximum: Settings.validations.comment.content.max_length, allow_blank: true}
  validates :review, :user, presence: true
end
