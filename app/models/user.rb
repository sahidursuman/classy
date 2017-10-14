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

  validates :first_name, presence: true, length: {maximum: Settings.user.first_name.max_length}
  validates :last_name, presence: true, length: {maximum: Settings.user.last_name.max_length}
  validates :role, presence: true

  before_create :generate_username

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

  class << self
    def find_for_database_authentication warden_conditions
      conditions = warden_conditions.dup
      if login = conditions.delete(:login).try(:downcase)
        where(conditions.to_hash).where(username: login).or(User.where email: login).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
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
end
