class BuildParentChildCategory < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :training_type_id
    add_column :categories, :type, :string
    add_column :categories, :parent_id, :bigint
    add_index :categories, :parent_id
  end
end
