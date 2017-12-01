Rails.application.routes.draw do
  Dir.glob(Rails.root.join "config", "constraints", "*.rb").each do |f_name|
    require f_name
  end

  get ":center_slug", to: "centers#show", as: "center", constraints: CenterConstraint.new
  get ":center_slug/reviews", to: "center/reviews#index", as: "center_reviews",
    constraints: CenterConstraint.new
  get ":center_slug/new-review/", to: "center/reviews#new", as: "new_center_review",
    constraints: CenterConstraint.new
  post ":center_slug/new-review/", to: "center/reviews#create", as: "center_review",
    constraints: CenterConstraint.new
  get ":center_slug/branches", to: "center/branches#index", as: "center_branches",
    constraints: CenterConstraint.new
  get ":center_slug/:branch_slug", to: "branches#show", as: "branch",
    constraints: BranchConstraint.new
  get ":center_slug/:branch_slug/reviews", to: "branch/reviews#index", as: "branch_reviews",
    constraints: BranchConstraint.new

  search_controller = "search/centers#index"
  get "search/:city_name/:district_name/:category_name", to: search_controller,
    constraints: CityDistrictConstraint.new(CategoryConstraint.new)
  get "search/:city_name/:category_name", to: search_controller,
    constraints: CityConstraint.new(CategoryConstraint.new)
end
