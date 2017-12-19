class Supports::ReviewVerification
  attr_reader :center

  def initialize center
    @center = center
  end

  def branch_options
    @branch_options ||= center.branches.order_name_asc.includes(:city).group_by{|b| b.city}
      .sort_by{|k, v| k.priority}.reverse.map{|k, v| [k.name, v.pluck(:name, :slug)]}
  end
end
