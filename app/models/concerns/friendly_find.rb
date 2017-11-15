module FriendlyFind
  extend ActiveSupport::Concern
  
  class_methods do 
    def friendly_findable findable_column
      @@findable_column = findable_column
      class << self
        def friendly_find param
          find_by! @@findable_column => param
        end
      end
    end
  end
end
