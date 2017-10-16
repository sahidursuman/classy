class AddDeletedAtToReviewVerifications < ActiveRecord::Migration[5.1]
  def change
    add_column :review_verifications, :deleted_at, :datetime
    add_index :review_verifications, :deleted_at
  end
end
