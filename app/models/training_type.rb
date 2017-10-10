class TrainingType < ApplicationRecord
  has_many :training_centers
  has_many :categories
end
