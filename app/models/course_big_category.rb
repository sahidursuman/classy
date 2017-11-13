class CourseBigCategory < CourseCategory
  belongs_to :center_category, class_name: CenterCategory.name, foreign_key: :parent_id
  has_many :course_small_categories, class_name: CourseSmallCategory.name, foreign_key: :parent_id
end
