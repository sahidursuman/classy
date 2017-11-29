class Course < ApplicationRecord
  attr_accessor :tmp_course_sub_category_ids

  ATTRIBUTES = [:name, :input, :output, :description, :price, :category_id,
    tmp_course_sub_category_ids: []]

  belongs_to :center
  belongs_to :course_category, class_name: CourseCategory.name, foreign_key: :category_id
  has_many :course_classifications
  has_many :course_sub_categories, through: :course_classifications

  validates :name, presence: true, length: {maximum: Settings.validations.course.name.max_length}
  validates :input, presence: true, length: {maximum: Settings.validations.course.input.max_length}
  validates :output, presence: true, length: {maximum: Settings.validations.course.output.max_length}
  validates :description, presence: true,
    length: {maximum: Settings.validations.course.description.max_length}
  validates :price, numericality: {only_integer: true, allow_blank: true}
  validates :category_id, presence: true

  scope :min_price_on_center, -> do
    group(:center_id).select "center_id, MIN(price) as min_price, COUNT(*) as count_course"
  end

  accepts_nested_attributes_for :course_classifications, allow_destroy: true
end
