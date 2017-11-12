class CourseSmallCategory < CourseCategory
  belongs_to :course_big_category, class_name: CourseBigCategory.name, foreign_key: :parent_id
end
