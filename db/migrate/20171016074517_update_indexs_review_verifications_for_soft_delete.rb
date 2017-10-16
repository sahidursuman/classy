class UpdateIndexsReviewVerificationsForSoftDelete < ActiveRecord::Migration[5.1]
  def change
    remove_index :review_verifications, :review_id
    add_index :review_verifications, :review_id, where: "deleted_at IS NULL"
  end
end
