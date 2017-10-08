class User < ApplicationRecord
  has_one :training_center_management
  has_many :branch_managements
  has_many :training_center_requests
  has_many :reviews
  has_many :comments
  has_many :votes
end
