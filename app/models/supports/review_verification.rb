class Supports::ReviewVerification
  attr_reader :center

  def initialize center
    @center = center
  end

  def branch_options
    @branch_options ||= center.branches.pluck :name, :slug
  end
end
