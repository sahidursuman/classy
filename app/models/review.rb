class Review < ApplicationRecord
  SORTING_OPTIONS = [
    {name: :newest, value: "created_at asc"},
    {name: :most_voting, value: "vote_points_cached desc"}
  ]
  ATTRIBUTES_TO_CREATE = [:branch_id, :rating_criterion_1, :rating_criterion_2,
    :rating_criterion_3, :rating_criterion_4, :rating_criterion_5, :title, :content,
    :email_verifiable, :phone_number_verifiable]
  belongs_to :center
  belongs_to :user
  belongs_to :branch, optional: true
  has_many :comments, dependent: :destroy
  has_many :votes
  has_many :review_verifications, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  validates :title, presence: true, length: {minimum: Settings.validations.review.title.min_length,
    maximum: Settings.validations.review.title.max_length, allow_blank: true}
  validates :content, presence: true, length: {minimum: Settings.validations.review.content.min_length,
    maximum: Settings.validations.review.content.max_length, allow_blank: true}
  validates :rating_criterion_1, :rating_criterion_2, :rating_criterion_3,
    :rating_criterion_4, :rating_criterion_5, presence: true,
    numericality: {only_integer: true, allow_blank: true}
  validates :email_verifiable, presence: true, email_format: true,
    length: {maximum: Settings.validations.review.email.max_length}
  validates :phone_number_verifiable, presence: true, phone_number_format: true

  scope :recent_created, ->{order created_at: :desc}
  scope :with_voted_type_by_user, ->user do
    joins("LEFT OUTER JOIN #{Vote.table_name}
      ON #{Review.table_name}.id = #{Vote.table_name}.review_id AND #{Vote.table_name}.user_id = #{user.id}")
      .select("#{Review.table_name}.*, #{Vote.table_name}.vote_type AS voted_type")
  end

  enum status: [:unverified, :verified, :rejected]

  acts_as_paranoid

  delegate :name, :route_params, to: :branch, prefix: true, allow_nil: true

  def update_vote_points_cached
    update_columns vote_points_cached: Vote.points_of_review(self)
  end
end
