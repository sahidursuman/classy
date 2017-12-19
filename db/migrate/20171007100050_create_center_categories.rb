class CreateCenterCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :center_categories do |t|
      t.references :category, foreign_key: true
      t.references :center, foreign_key: true

      t.timestamps
    end
  end
end
