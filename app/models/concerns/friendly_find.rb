module FriendlyFind
  extend ActiveSupport::Concern
  
  class_methods do 
    def friendly_findable friendly_findable_column
      @friendly_findable_column = friendly_findable_column
      class << self
        def friendly_find param
          find_by! @friendly_findable_column => param
        end
      end
    end
  end
end
