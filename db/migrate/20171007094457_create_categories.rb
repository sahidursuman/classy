class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :training_type, foreign_key: true

      t.timestamps
    end
  end
end
