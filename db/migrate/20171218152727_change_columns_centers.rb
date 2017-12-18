class ChangeColumnsCenters < ActiveRecord::Migration[5.1]
  def change
    rename_column :centers, :logo, :cover_image
    rename_column :centers, :description, :overview
    add_column :centers, :teacher_staff_intro, :text
    add_column :centers, :curriculum_overview, :text
  end
end
