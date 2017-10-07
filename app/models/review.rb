class Review < ApplicationRecord
  belongs_to :user
  belongs_to :branch
  has_many :comments
  has_many :votes
end
