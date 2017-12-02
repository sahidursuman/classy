class RenameColumnCachedAverageRatingOfCenters < ActiveRecord::Migration[5.1]
  def change
    rename_column :centers, :cached_average_rating, :summary_rating_cached
  end
end
