class ReviewVerification < ApplicationRecord
  PARAMS_VERIFY = [:status]

  belongs_to :review
  has_one :branch, through: :review

  scope :recent_created, ->{order created_at: :desc}
  scope :by_branch_ids, ->branch_ids do
    joins(:review).where reviews: {branch_id: branch_ids}
  end

  after_save :set_review_verified, if: :verified?

  enum status: [:forwarded, :verified, :rejected]

  acts_as_paranoid

  delegate :name, :full_name, to: :branch, prefix: true

  private
  def set_review_verified
    review.verified!
  end
end
