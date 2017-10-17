class VoteForm
  include Virtus.model
  include ActiveModel::Model

  PARAMS = [:vote_type]

  attribute :user, User
  attribute :review, Review
  attribute :vote_type, String

  validates :user, presence: true
  validates :review, presence: true
  validates :vote_type, presence: true, inclusion: {in: Vote::vote_types.keys}

  def save
    if valid? && persist!
      true
    else
      false
    end
  end

  private
  def persist!
    vote = Vote.find_or_initialize_by user: user, review: review
    vote.assign_attributes vote_type: vote_type
    vote.save
  end
end
