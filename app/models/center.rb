class Center < ApplicationRecord
  extend FriendlyFind

  ATTRIBUTES = [:name, :training_type_id, :logo, :avatar, :description, :email, :phone_number]

  belongs_to :training_type
  has_many :center_managements
  has_many :branches
  has_many :center_categories
  has_many :active_branches, ->{active}, class_name: Branch.name
  has_many :cities, ->{distinct}, through: :branches
  has_many :active_branches_cities, ->{distinct}, through: :active_branches,
    source: :city

  validates :logo, file_size: {less_than_or_equal_to: eval(Settings.validations.center.logo.max_size)}
  validates :avatar, file_size: {less_than_or_equal_to: eval(Settings.validations.center.avatar.max_size)}
  validates :name, presence: true, length: {maximum: Settings.validations.center.name.max_length}
  validates :training_type_id, presence: true
  validates :description, length: {maximum: Settings.validations.center.description.max_length}
  validates :email, email_format: true, length: {maximum: Settings.validations.center.email.max_length}
  validates :phone_number, phone_number_format: true

  enum status: [:active, :inactive]

  acts_as_url :name, url_attribute: :slug, sync_url: true, callback_method: :before_save

  mount_uploader :avatar, BusinessAvatarUploader
  mount_uploader :logo, AvatarUploader

  delegate :name, to: :training_type, prefix: true, allow_nil: true

  def route_params
    {center_slug: slug}
  end
end
