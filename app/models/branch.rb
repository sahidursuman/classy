class Branch < ApplicationRecord
  include FriendlyUrl

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\A([-\u2212\u30fc]*[\d０-９]){10,11}\z/
  ATTRIBUTES = [:name, :avatar, :avatar_cache, :description, :city_id, :district_id,
    :address, :phone_number, :email]

  belongs_to :center
  belongs_to :city
  belongs_to :district
  has_many :branch_managements
  has_many :branch_managers, through: :branch_managements, source: :user
  has_many :reviews
  has_many :comments

  validates :avatar, file_size: {less_than_or_equal_to: eval(Settings.validations.branch.avatar.max_size)}
  validates :name, presence: true, length: {maximum: Settings.validations.branch.name.max_length}
  validates :city_id, :district_id, presence: true
  validates :address, presence: true, length: {maximum: Settings.validations.branch.address.max_length}
  validates :phone_number, presence: true, format: {with: VALID_PHONE_NUMBER_REGEX, allow_blank: true}
  validates :email, format: {with: VALID_EMAIL_REGEX, allow_blank: true}
  validates :description, length: {maximum: Settings.validations.branch.description.max_length}

  before_validation :geocode, if: :require_geocode?

  enum status: [:active, :inactive]

  acts_as_url :full_name, url_attribute: :slug, sync_url: true, callback_method: :before_save

  delegate :name, to: :center, prefix: true, allow_nil: true
  delegate :name, to: :city, prefix: true, allow_nil: true
  delegate :name, to: :district, prefix: true, allow_nil: true

  geocoded_by :full_address

  mount_uploader :avatar, BusinessAvatarUploader

  def full_name
    center.name + " - " + name
  end

  def full_address
    [address, district_name, city_name].join ", "
  end

  private
  def require_geocode?
    errors.blank? && (address_changed? || city_id_changed? || district_id_changed?)
  end
end
