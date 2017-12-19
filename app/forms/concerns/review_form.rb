module ReviewForm
  include Virtus.module
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  attribute :title, String
  attribute :content, String
  attribute :rating_criterion_1, Integer
  attribute :rating_criterion_2, Integer
  attribute :rating_criterion_3, Integer
  attribute :rating_criterion_4, Integer
  attribute :rating_criterion_5, Integer

  included do
    validates :title, presence: true, length: {minimum: Settings.validations.review.title.min_length,
      maximum: Settings.validations.review.title.max_length, allow_blank: true}
    validates :content, presence: true, length: {minimum: Settings.validations.review.content.min_length,
      maximum: Settings.validations.review.content.max_length, allow_blank: true}
    validates :rating_criterion_1, :rating_criterion_2, :rating_criterion_3,
      :rating_criterion_4, :rating_criterion_5, presence: true,
      numericality: {only_integer: true, allow_blank: true}
  end
end
