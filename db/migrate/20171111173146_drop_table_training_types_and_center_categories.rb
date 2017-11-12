class DropTableTrainingTypesAndCenterCategories < ActiveRecord::Migration[5.1]
  def change
    drop_table :training_types
    drop_table :center_categories
  end
end
