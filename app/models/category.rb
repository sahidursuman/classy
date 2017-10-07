class Category < ApplicationRecord
  belongs_to :training_type
  has_many :training_center_categories
end
