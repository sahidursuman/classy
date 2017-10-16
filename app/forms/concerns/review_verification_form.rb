module ReviewVerificationForm
  include Virtus.module
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\A([-\u2212\u30fc]*[\d０-９]){10,11}\z/

  attribute :email_verify, String
  attribute :phone_number_verify, String

  included do
    validates :email_verify, presence: true, format: {with: VALID_EMAIL_REGEX, allow_blank: true},
      length: {maximum: Settings.validations.review_verification.email.max_length}
    validates :phone_number_verify, presence: true,
      format: {with: VALID_PHONE_NUMBER_REGEX, allow_blank: true}
  end
end
