class RenameColumnAverageRatingToSummaryRating < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :average_rating, :summary_rating
  end
end
