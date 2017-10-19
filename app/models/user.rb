class User < ApplicationRecord
  attr_accessor :login

  has_one :center_management
  has_one :managed_center, through: :center_management, source: :center
  has_many :branch_managements
  has_many :managed_branches, through: :branch_managements, source: :branch
  has_many :center_requests
  has_many :reviews
  has_many :comments
  has_many :votes

  PERSONAL_INFORMATION_PARAMS = [:first_name, :last_name, :phone_number]
  ACCOUNT_INFORMATION_PARAMS = [:username, :email, :current_password]

  validates :first_name, presence: true, length: {maximum: Settings.user.first_name.max_length}
  validates :last_name, presence: true, length: {maximum: Settings.user.last_name.max_length}
  validates :role, presence: true
  validates :username, presence: true, uniqueness: true, on: :update

  before_create :generate_username
  before_save :downcase_fields

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role: [:admin, :moderator, :center_manager, :branch_manager, :normal_user]

  def working_center
    if center_manager?
      managed_center
    elsif branch_manager?
      managed_branches.first.try :center
    end
  end

  def branches_under_management
    if center_manager?
      managed_center.branches
    elsif branch_manager?
      managed_branches
    end
  end

  def to_param
    username
  end

  class << self
    def find_for_database_authentication warden_conditions
      conditions = warden_conditions.dup
      if login = conditions.delete(:login).try(:downcase)
        where(conditions.to_hash).where(username: login).or(User.where email: login).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
    end

    def friendly_find param
      find_by! username: param.try(:downcase)
    end
  end

  private
  def generate_username
    self.username = tmp_username = email[/^[^@]+/]
    loop do
      break unless User.exists? username: username
      self.username = tmp_username << SecureRandom.hex(Settings.user.username.random_suffix_length)
    end
  end

  def downcase_fields
     self.username = self.username.try :downcase
  end
end
