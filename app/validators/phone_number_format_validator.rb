class PhoneNumberFormatValidator < ActiveModel::EachValidator
  VALID_PHONE_NUMBER_REGEX = /\A([-\u2212\u30fc]*[\d０-９]){10,11}\z/

  def validate_each record, attribute, value
    if value.present? && value !~ VALID_PHONE_NUMBER_REGEX
      record.errors.add attribute, :invalid
    end
  end
end
