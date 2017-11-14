class CourseSubCategory < Category
  belongs_to :course_category, class_name: CourseCategory.name, foreign_key: :parent_id
  has_many :course_classifications, class_name: CourseClassification.name, foreign_key: :category_id
end
