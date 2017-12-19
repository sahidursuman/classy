class RemoveCategoryIdFromCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :category_id
  end
end
