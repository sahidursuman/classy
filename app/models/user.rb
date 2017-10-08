class User < ApplicationRecord
  attr_accessor :login

  has_one :training_center_management
  has_many :branch_managements
  has_many :training_center_requests
  has_many :reviews
  has_many :comments
  has_many :votes

  validates_presence_of :first_name, :last_name, :role
  validates_length_of :first_name, maximum: Settings.user.first_name.max_length
  validates_length_of :last_name, maximum: Settings.user.last_name.max_length

  before_create :generate_username

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role: [:admin, :moderator, :center_manager, :branch_manager, :member]

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
