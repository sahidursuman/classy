  module FriendlyFind
    def friendly_find param
      find_by! slug: param
    end
  end
