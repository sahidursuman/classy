class UpdateIndexsReviewsForSoftDelete < ActiveRecord::Migration[5.1]
  def change
    remove_index :reviews, :branch_id
    add_index :reviews, :branch_id, where: "deleted_at IS NULL"
    remove_index :reviews, :user_id
    add_index :reviews, :user_id, where: "deleted_at IS NULL"
  end
end
