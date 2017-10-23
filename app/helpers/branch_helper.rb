module BranchHelper
  def branch_status_options
    Branch::statuses.map {|k, v| [t(".#{k}"), v]}
  end
end
