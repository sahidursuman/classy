class CourseCategory < Category
  belongs_to :center_category, class_name: CenterCategory.name, foreign_key: :parent_id
  has_many :course_sub_categories, class_name: CourseSubCategory.name, foreign_key: :parent_id
  has_many :courses, class_name: Course.name, foreign_key: :category_id
end
