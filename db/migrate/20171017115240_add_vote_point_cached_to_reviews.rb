class AddVotePointCachedToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :vote_points_cached, :integer, null: false, default: 0
  end
end
