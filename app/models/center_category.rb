class CenterCategory < Category
  has_many :course_big_categories, class_name: CourseBigCategory.name, foreign_key: :parent_id
end
