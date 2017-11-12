class CenterCategory < Category
  has_many :centers, foreign_key: :category_id
  has_many :course_big_categories, class_name: CourseBigCategory.name, foreign_key: :parent_id
  has_many :course_small_categories, through: :course_big_categories

  def course_categories
    course_big_categories + course_small_categories
  end
end
