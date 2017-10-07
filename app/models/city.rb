class City < ApplicationRecord
  has_many :districts
  has_many :branches
end
