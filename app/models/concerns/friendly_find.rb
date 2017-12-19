module FriendlyFind
  extend ActiveSupport::Concern
  
  class_methods do 
    def friendly_findable friendly_column
      define_singleton_method :friendly_find do |param|
        find_by! friendly_column => param
      end
    end
  end
end
