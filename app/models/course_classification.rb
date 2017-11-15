class CourseClassification < ApplicationRecord
  belongs_to :course
  belongs_to :course_sub_category, class_name: CourseSubCategory.name, foreign_key: :category_id
end
