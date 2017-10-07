class CreateTrainingCenterCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :training_center_categories do |t|
      t.references :category, foreign_key: true
      t.references :training_center, foreign_key: true

      t.timestamps
    end
  end
end
