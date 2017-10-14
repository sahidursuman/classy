class CreateReviewForm
  include Virtus
  include ActiveModel::Model

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  PARAMS = [:title, :content, :rating_criterion_1, :rating_criterion_2,
    :rating_criterion_3, :rating_criterion_4, :rating_criterion_5, :email_verify,
    :phone_number_verify]

  attribute :user_id, Integer
  attribute :branch_id, Integer
  attribute :title, String
  attribute :content, String
  attribute :rating_criterion_1, Integer
  attribute :rating_criterion_2, Integer
  attribute :rating_criterion_3, Integer
  attribute :rating_criterion_4, Integer
  attribute :rating_criterion_5, Integer
  attribute :email_verify, String
  attribute :phone_number_verify, String

  validates :user_id, :branch_id, presence: true
  validates :title, presence: true, length: {minimum: Settings.validations.review.title.min_length,
    maximum: Settings.validations.review.title.max_length, allow_blank: true}
  validates :content, presence: true, length: {minimum: Settings.validations.review.content.min_length,
    maximum: Settings.validations.review.content.max_length, allow_blank: true}
  validates :rating_criterion_1, :rating_criterion_2, :rating_criterion_3,
    :rating_criterion_4, :rating_criterion_5, presence: true,
    numericality: {only_integer: true, allow_blank: true}
  validates :email_verify, presence: true, format: {with: VALID_EMAIL_REGEX, allow_blank: true},
    length: {maximum: Settings.validations.review_verification.email.max_length}
  validates :phone_number_verify, presence: true

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private
  def persist!
    review = Review.new user_id: user_id, branch_id: branch_id, title: title,
      content: content, rating_criterion_1: rating_criterion_1,
      rating_criterion_2: rating_criterion_2, rating_criterion_3: rating_criterion_3,
      rating_criterion_4: rating_criterion_4, rating_criterion_5: rating_criterion_5,
      status: :unverified
    review.review_verifications.build email: email_verify, phone_number: phone_number_verify,
      status: :forwarded
    review.save!
  end
end
