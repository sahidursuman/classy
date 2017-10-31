class CenterConstraint
  def matches? request
    Center.exists? slug: request[:center_slug]
  end
end
