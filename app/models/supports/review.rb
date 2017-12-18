class Supports::Review
  attr_reader :review

  def initialize review
    @review = review
  end

  def branch_options
    @branch_options ||= review.center.branches.order_name_asc.includes(:city).group_by{|b| b.city}
      .sort_by{|k, v| k.priority}.reverse.map{|k, v| [k.name, v.pluck(:name, :id)]}
  end
end
