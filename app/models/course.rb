class Course < ApplicationRecord
  ATTRIBUTES = [:name, :input, :output, :description, :price, category_ids: []]

  belongs_to :center
  has_many :course_classifications
  has_many :categories, through: :course_classifications

  validates :name, presence: true, length: {maximum: Settings.validations.course.name.max_length}
  validates :input, presence: true, length: {maximum: Settings.validations.course.input.max_length}
  validates :output, presence: true, length: {maximum: Settings.validations.course.output.max_length}
  validates :description, presence: true, 
    length: {maximum: Settings.validations.course.description.max_length}
  validates :price, numericality: {only_integer: true, allow_blank: true}

  accepts_nested_attributes_for :course_classifications, allow_destroy: true
end
