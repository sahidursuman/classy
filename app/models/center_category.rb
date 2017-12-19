class CenterCategory < Category
  has_many :centers, foreign_key: :category_id
  has_many :course_categories, class_name: CourseCategory.name, foreign_key: :parent_id
end
