class UpdateIndexsCommentsForSoftDelete < ActiveRecord::Migration[5.1]
  def change
    remove_index :comments, :branch_id
    add_index :comments, :branch_id, where: "deleted_at IS NULL"
    remove_index :comments, :review_id
    add_index :comments, :review_id, where: "deleted_at IS NULL"
    remove_index :comments, :user_id
    add_index :comments, :user_id, where: "deleted_at IS NULL"
  end
end
