class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  after_save :update_review_vote_points_cached
  after_destroy :update_review_vote_points_cached

  acts_as_paranoid

  enum vote_type: [:up, :down]

  class << self
    def points_of_review review
      where(review_id: review.id)
        .sum "CASE WHEN #{Vote.table_name}.vote_type=#{Vote::vote_types[:up]}
          THEN #{Settings.vote.vote_type_point.up} ELSE #{Settings.vote.vote_type_point.down} END"
    end
  end

  private
  def update_review_vote_points_cached
    review.update_vote_points_cached
  end
end
