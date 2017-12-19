module ReviewVerificationHelper
  def review_verification_status_options
    Review::statuses.map {|k, v| [t(".#{k}"), v]}
  end
end
