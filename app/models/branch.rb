class Branch < ApplicationRecord
  ATTRIBUTES = [:name, :city_id, :district_id, :address, :phone_number, :email]

  belongs_to :center
  belongs_to :city
  belongs_to :district
  has_many :branch_managements
  has_many :branch_managers, through: :branch_managements, source: :user
  has_many :reviews
  has_many :comments

  validates :name, presence: true, length: {maximum: Settings.validations.branch.name.max_length}
  validates :city_id, :district_id, presence: true
  validates :address, presence: true, length: {maximum: Settings.validations.branch.address.max_length}
  validates :phone_number, presence: true, phone_number_format: true
  validates :email, email_format: true

  before_save :geocode, if: :require_geocode?

  scope :order_name_asc, ->{order name: :asc}

  enum status: [:active, :inactive]

  acts_as_url :name, url_attribute: :slug, scope: :center_id, sync_url: true,
    callback_method: :before_save

  delegate :name, :route_params, to: :center, prefix: true, allow_nil: true
  delegate :name, to: :city, prefix: true, allow_nil: true
  delegate :name, to: :district, prefix: true, allow_nil: true

  geocoded_by :full_address

  friendly_findable :slug

  def full_address
    [address, district_name, city_name].join ", "
  end

  def route_params
    center.route_params.merge branch_slug: slug
  end

  private
  def require_geocode?
    errors.blank? && (address_changed? || city_id_changed? || district_id_changed?)
  end
end
