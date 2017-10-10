module FriendlyUrl
  class << self
    def included base
      base.extend FriendlyFind
    end
  end

  def to_param
    slug
  end
end
