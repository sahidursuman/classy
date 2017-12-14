class CenterCourseConstraint
  def matches? request
    Center.exists?(slug: request[:center_slug]) && Course.exists?(slug: request[:course_slug])
  end
end
