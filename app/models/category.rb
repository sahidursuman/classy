class Category < ApplicationRecord
  belongs_to :training_type
  has_many :center_categories
end
