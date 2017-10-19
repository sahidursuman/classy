module BranchHelper
  def branch_status_options
    Branch::statuses.map &:to_a
  end
end
