class Review < ApplicationRecord
  belongs_to :user
  belongs_to :branch
  has_many :comments, dependent: :destroy
  has_many :votes
  has_many :review_verifications, dependent: :destroy

  scope :recent_created, ->{order created_at: :desc}

  enum status: [:unverified, :verified]

  acts_as_paranoid
end
