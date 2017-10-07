class City < ApplicationRecord
  has_many :district
  has_many :branches
end
