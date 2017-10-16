class AddIndexCommentToDeletedAt < ActiveRecord::Migration[5.1]
  def change
    add_index :comments, :deleted_at
  end
end
