class AddIndexReviewUserOnVotes < ActiveRecord::Migration[5.1]
  def change
    add_index :votes, [:user_id, :review_id], unique: true, where: "deleted_at IS NULL"
  end
end
