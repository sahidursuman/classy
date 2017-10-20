class Supports::ReviewVerification
  attr_reader :branches

  def initialize branches
    @branches = branches
  end

  def branch_options
    @branch_options ||= branches.pluck :name, :slug
  end
end
