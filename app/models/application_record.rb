class ApplicationRecord < ActiveRecord::Base
  include FriendlyFind
  self.abstract_class = true

  class << self   
    def ransack_search_result condition = {}, is_distinct = true
      ransack(condition).result distinct: is_distinct
    end
  end
end
