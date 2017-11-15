class ApplicationRecord < ActiveRecord::Base
  include FriendlyFind
  
  self.abstract_class = true
end
