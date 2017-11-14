class AddReferencesToCourse < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :category, index: true, foreign_key: true
  end
end
