module ReviewVerificationHelper
  def review_verification_status_options
    ReviewVerification::statuses.map &:to_a
  end
end
