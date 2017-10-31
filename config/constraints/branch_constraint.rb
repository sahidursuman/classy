class BranchConstraint
  def matches? request
    (center = Center.friendly_find request[:center_slug]) && 
      center.branches.exists?(slug: request[:branch_slug])
  end
end
