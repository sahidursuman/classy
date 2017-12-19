class Center < ApplicationRecord
  include PgSearch

  ATTRIBUTES = [:name, :cover_image, :avatar, :overview, :email, :phone_number, :teacher_staff_intro,
    :curriculum_overview]
  ADMIN_PERSIT_PARAMS = [:name, :cover_image, :avatar, :overview, :email, :phone_number,
    :teacher_staff_intro, :curriculum_overview, :category_id]
  SORT_OPTIONS = [:recommendation_order, :summary_rating_desc, :minimum_tuition_fee_asc,
    :minimum_tuition_fee_desc]

  belongs_to :center_category, foreign_key: :category_id
  has_many :center_managements
  has_many :branches
  has_many :center_categories
  has_many :active_branches, ->{active}, class_name: Branch.name
  has_many :cities, ->{distinct}, through: :branches
  has_many :active_branches_cities, through: :active_branches,
    source: :city
  has_many :reviews
  has_many :courses
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :notifications, as: :notifiable
  has_many :managers, through: :center_managements, source: :user
  has_many :course_categories, ->{distinct}, through: :courses

  validates :cover_image, file_size: {less_than_or_equal_to: eval(Settings.validations.center.logo.max_size)}
  validates :avatar, file_size: {less_than_or_equal_to: eval(Settings.validations.center.avatar.max_size)}
  validates :name, presence: true, length: {maximum: Settings.validations.center.name.max_length}
  validates :category_id, presence: true
  validates :overview, presence: true, length: {maximum: Settings.validations.center.description.max_length}
  validates :curriculum_overview, :teacher_staff_intro,
    length: {maximum: Settings.validations.center.description.max_length}
  validates :email, presence: true, email_format: true,
    length: {maximum: Settings.validations.center.email.max_length}
  validates :phone_number, presence: true, phone_number_format: true

  before_save :generate_normalized_name

  scope :recommendation_order, ->{}
  scope :summary_rating_desc, ->{order "summary_rating_cached DESC NULLS LAST"}
  scope :minimum_tuition_fee_asc, ->{order "min_course_tuition_fee ASC NULLS LAST"}
  scope :minimum_tuition_fee_desc, ->{order "min_course_tuition_fee DESC NULLS LAST"}
  scope :order_by, ->(order_option){public_send order_option}

  enum status: [:active, :inactive]

  acts_as_url :name, url_attribute: :slug, sync_url: true, callback_method: :before_save

  mount_uploader :avatar, AvatarUploader

  delegate :name, to: :center_category, prefix: true, allow_nil: true

  friendly_findable :slug

  is_impressionable

  pg_search_scope :full_text_search, against: {name: "A", normalized_name: "B"}

  ransack_alias :city_key_name, :active_branches_city_key_name
  ransack_alias :district_key_name, :active_branches_district_key_name

  def route_params
    {center_slug: slug}
  end

  def update_summary_rating_cached
    center_rating = reviews.verified.select("SUM(summary_rating) / COUNT(*) AS rating")[0].rating
    update_column :summary_rating_cached, center_rating
  end

  def generate_normalized_name
    self.normalized_name = name.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,"")
  end

  class << self
    def ransackable_scopes auth_object = nil
      %i(order_by)
    end
  end
end
