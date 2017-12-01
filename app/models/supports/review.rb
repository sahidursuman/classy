class Supports::Review
  attr_reader :review

  def initialize review
    @review = review
  end

  def branch_options
    @branch_options ||= review.center.branches.pluck :name, :id
  end
end
