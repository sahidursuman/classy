class ReviewVerification < ApplicationRecord
  belongs_to :review

  enum status: [:forwarded, :verified, :rejected]
end
