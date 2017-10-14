class TrainingType < ApplicationRecord
  has_many :centers
  has_many :categories
end
