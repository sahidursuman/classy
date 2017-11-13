class CreateCourseClassifications < ActiveRecord::Migration[5.1]
  def change
    create_table :course_classifications do |t|
      t.references :course, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
