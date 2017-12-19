class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.references :category, foreign_key: true
      t.references :center, foreign_key: true
      t.string :name
      t.string :input
      t.string :output
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
