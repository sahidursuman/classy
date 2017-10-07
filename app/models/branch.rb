class Branch < ApplicationRecord
  belongs_to :training_center
  belongs_to :city
  belongs_to :district
  has_many :branch_managements
  has_many :reviews
  has_many :comments
end
