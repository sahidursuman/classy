class ReviewVerification < ApplicationRecord
  belongs_to :review

  enum status: [:forwarded, :verified, :rejected]

  acts_as_paranoid
end
