class TrainingCenter < ApplicationRecord
  include FriendlyUrl

  belongs_to :training_type
  has_many :training_center_managements
  has_many :branches
  has_many :training_center_categories
end
