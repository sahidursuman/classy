class ChangeColumnsOfCourses < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :input, :string
    remove_column :courses, :description, :text
    remove_column :courses, :output, :string
    remove_column :courses, :duration, :string
    add_column :courses, :intended_student, :text
    add_column :courses, :target, :text
    add_column :courses, :curriculum, :text
    add_column :courses, :teaching_methods, :text
    add_column :courses, :class_size, :integer
    add_column :courses, :duration, :float
    add_column :courses, :sessions, :integer
    add_column :courses, :slug, :string
    rename_column :courses, :price, :tuition_fee
  end
end
