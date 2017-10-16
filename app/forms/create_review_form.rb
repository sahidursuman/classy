class CreateReviewForm
  include Virtus
  include ActiveModel::Model
  include ReviewForm
  include ReviewVerificationForm

  PARAMS = [:title, :content, :rating_criterion_1, :rating_criterion_2,
    :rating_criterion_3, :rating_criterion_4, :rating_criterion_5, :email_verify,
    :phone_number_verify]

  attribute :user, User
  attribute :branch, Branch

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
    review = Review.new user: user, branch: branch, title: title,
      content: content, rating_criterion_1: rating_criterion_1,
      rating_criterion_2: rating_criterion_2, rating_criterion_3: rating_criterion_3,
      rating_criterion_4: rating_criterion_4, rating_criterion_5: rating_criterion_5,
      status: :unverified
    review.review_verifications.build email: email_verify, phone_number: phone_number_verify,
      status: :forwarded
    review.save!
  end
end
