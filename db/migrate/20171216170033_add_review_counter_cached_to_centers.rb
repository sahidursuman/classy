class AddReviewCounterCachedToCenters < ActiveRecord::Migration[5.1]
  def change
    add_column :centers, :review_counter_cached, :integer, default: 0
  end
end
