module ReviewVerificationHelper
  def review_verification_status_options
    ReviewVerification::statuses.map {|k, v| [t(".#{k}"), v]}
  end
end
