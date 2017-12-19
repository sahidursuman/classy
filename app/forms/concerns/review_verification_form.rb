module ReviewVerificationForm
  include Virtus.module
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  attribute :email_verify, String
  attribute :phone_number_verify, String

  included do
    validates :email_verify, presence: true, email_format: true
    validates :phone_number_verify, presence: true, phone_number_format: true
  end
end
