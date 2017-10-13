class Review < ApplicationRecord
  belongs_to :user
  belongs_to :branch
  has_many :comments
  has_many :votes
  has_many :review_verifications

  scope :recent_created, ->{order created_at: :desc}

  enum status: [:unverified, :verified]
end
