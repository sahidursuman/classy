Rails.application.routes.draw do
  Dir.glob(Rails.root.join "config", "constraints", "*.rb").each do |f_name|
    require f_name
  end

  get ":center_slug", to: "centers#show", as: "center", constraints: CenterConstraint.new
  get ":center_slug/branches", to: "center/branches#index", as: "center_branches",
    constraints: CenterConstraint.new
  get ":center_slug/:branch_slug", to: "branches#show", as: "branch",
    constraints: BranchConstraint.new
  get ":center_slug/:branch_slug/reviews", to: "branch/reviews#index", as: "branch_reviews",
    constraints: BranchConstraint.new
end
