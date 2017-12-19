class Course < ApplicationRecord
  attr_accessor :tmp_course_sub_category_ids

  ATTRIBUTES = [:name, :category_id, :intended_student, :target, :sessions, :duration,
    :class_size, :curriculum, :teaching_methods, :tuition_fee, tmp_course_sub_category_ids: []]

  belongs_to :center
  belongs_to :course_category, class_name: CourseCategory.name, foreign_key: :category_id
  has_many :course_classifications, dependent: :destroy
  has_many :course_sub_categories, through: :course_classifications

  validates :category_id, presence: true
  validates :name, presence: true, length: {maximum: Settings.validations.course.name.max_length}
  validates :intended_student, :target, presence: true,
    length: {maximum: Settings.validations.course.description.max_length}
  validates :sessions, presence: true, numericality: {only_integer: true,
    greater_than_or_equal_to: Settings.validations.course.sessions.minimum,
    less_than_or_equal_to: Settings.validations.course.sessions.maximum,
    allow_blank: true}
  validates :duration, presence: true, numericality: {
    greater_than_or_equal_to: Settings.validations.course.duration.minimum,
    less_than_or_equal_to: Settings.validations.course.duration.maximum,
    allow_blank: true}
  validates :curriculum, :teaching_methods,
    length: {maximum: Settings.validations.course.description.max_length}
  validates :tuition_fee, numericality: {only_integer: true,
    greater_than_or_equal_to: Settings.validations.course.tuition_fee.minimum,
    less_than_or_equal_to: Settings.validations.course.tuition_fee.maximum,
    allow_blank: true}
  validates :class_size, numericality: {only_integer: true,
    greater_than_or_equal_to: Settings.validations.course.class_size.minimum,
    less_than_or_equal_to: Settings.validations.course.class_size.maximum,
    allow_blank: true}

  scope :min_tuition_fee_on_center, -> do
    group(:center_id).select "center_id, MIN(tuition_fee) as min_tuition_fee, COUNT(*) as count_course"
  end

  accepts_nested_attributes_for :course_classifications, allow_destroy: true

  acts_as_url :name, url_attribute: :slug, scope: :center_id, sync_url: true,
    callback_method: :before_save

  friendly_findable :slug

  def route_params
    center.route_params.merge course_slug: slug
  end
end
