class AddIndexToReviews < ActiveRecord::Migration[5.1]
  def change
    add_index :reviews, :deleted_at
  end
end
