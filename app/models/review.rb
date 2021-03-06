class Review < ApplicationRecord
  SORT_OPTIONS = [:recent_created, :vote_points_desc, :summary_rating_desc, :summary_rating_asc]
  ATTRIBUTES_TO_PERSIST_CONTENT = [:branch_id, :rating_criterion_1, :rating_criterion_2,
    :rating_criterion_3, :rating_criterion_4, :rating_criterion_5, :title, :content]
  ATTRIBUTES_TO_PERSIST_VERIFICATION = [:email_verifiable, :phone_number_verifiable]
  PARAMS_VERIFY = [:status]
  ATTRIBUTES_TO_PERSIST_FULL = ATTRIBUTES_TO_PERSIST_CONTENT + ATTRIBUTES_TO_PERSIST_VERIFICATION

  belongs_to :center
  belongs_to :user
  belongs_to :branch, optional: true
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :review_verifications, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :created_notifications, class_name: Notification.name, as: :creatable,
    dependent: :destroy

  before_save :calculate_summary_rating, if: :rating_criteria_changed?
  after_save :update_center_summary_rating_cached, if: :influence_center_rating?
  after_save :notify_new_review_verification, if: :new_verification_request?

  validates :title, presence: true, length: {minimum: Settings.validations.review.title.min_length,
    maximum: Settings.validations.review.title.max_length, allow_blank: true}
  validates :content, presence: true, length: {minimum: Settings.validations.review.content.min_length,
    maximum: Settings.validations.review.content.max_length, allow_blank: true}
  validates :rating_criterion_1, :rating_criterion_2, :rating_criterion_3,
    :rating_criterion_4, :rating_criterion_5, presence: true,
    numericality: {only_integer: true, allow_blank: true, less_than_or_equal_to: 10,
    greater_than_or_equal_to: 1}
  validates :email_verifiable, presence: true, email_format: true,
    length: {maximum: Settings.validations.review.email.max_length}
  validates :phone_number_verifiable, presence: true, phone_number_format: true

  scope :recent_created, ->{order created_at: :desc}
  scope :vote_points_desc, ->{order vote_points_cached: :desc}
  scope :with_voted_type_by_user, ->user do
    joins("LEFT OUTER JOIN #{Vote.table_name}
      ON #{Review.table_name}.id = #{Vote.table_name}.review_id AND #{Vote.table_name}.user_id = #{user.id}")
      .select("#{Review.table_name}.*, #{Vote.table_name}.vote_type AS voted_type")
  end
  scope :summary_rating_desc, ->{order summary_rating: :desc}
  scope :summary_rating_asc, ->{order summary_rating: :asc}
  scope :order_by, ->(sort_scope){public_send sort_scope}

  enum status: [:unverified, :verified, :rejected]

  acts_as_paranoid

  counter_culture :center, column_name: proc {|model| model.verified? ? "review_counter_cached" : nil}

  delegate :name, :route_params, to: :branch, prefix: true, allow_nil: true
  delegate :name, :route_params, to: :center, prefix: true, allow_nil: true

  def update_vote_points_cached
    update_columns vote_points_cached: Vote.points_of_review(self)
  end

  class << self
    def ransackable_scopes auth_object = nil
      %i(order_by)
    end

    def avarage_rating
      attribute_list = Settings.review.criteria.map(&:attr_name).push "summary_rating"
      select_sql = attribute_list.map do |attribute|
        "CAST (SUM(#{attribute}) AS FLOAT)/COUNT(*) as #{attribute}_avg"
      end.join ", "
      select(select_sql)[0]
    end

    def classification
      Settings.review.levels.inject({}) do |result, level|
        review_counted = result.values.reduce 0, :+
        result.merge level.name.to_sym => ransack(summary_rating_gteq: level.standard).result.count - review_counted
      end.merge total: count
    end
  end

  private
  def rating_criteria_changed?
    Settings.review.criteria.map(&:attr_name).any? do |criterion|
      public_send "#{criterion}_changed?"
    end
  end

  def calculate_summary_rating
    self.summary_rating = Settings.review.criteria.inject(0) do |summary, criterion|
      summary + public_send(criterion.attr_name) * criterion.ratio
    end / 100.to_f
  end

  def influence_center_rating?
    verified? && (saved_change_to_status? || saved_change_to_summary_rating?)
  end

  def update_center_summary_rating_cached
    center.update_summary_rating_cached
  end

  def new_verification_request?
    unverified? && (saved_change_to_email_verifiable? || saved_change_to_phone_number_verifiable?)
  end

  def notify_new_review_verification
    center.managers.each do |manager|
      manager.received_notifications.create notifiable: center,
        action: :new_review_verification
    end
  end
end
