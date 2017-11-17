class CategoryConstraint
  def matches? request
    Category.exists? key_name: request[:category_name]
  end
end
