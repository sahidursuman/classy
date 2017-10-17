class EditReviewForm
  include Virtus.model
  include ActiveModel::Model
  include ReviewForm

  PARAMS = [:title, :content, :rating_criterion_1, :rating_criterion_2, :rating_criterion_3,
    :rating_criterion_4, :rating_criterion_5]

  attribute :review, Review

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
    review.assign_attributes title: title,
      content: content, rating_criterion_1: rating_criterion_1,
      rating_criterion_2: rating_criterion_2, rating_criterion_3: rating_criterion_3,
      rating_criterion_4: rating_criterion_4, rating_criterion_5: rating_criterion_5
    review.save!
  end
end
