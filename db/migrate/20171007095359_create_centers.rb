class CreateCenters < ActiveRecord::Migration[5.1]
  def change
    create_table :centers do |t|
      t.references :training_type, foreign_key: true
      t.string :name
      t.integer :status
      t.string :avatar
      t.text :description
      t.float :cached_average_rating

      t.timestamps
    end
  end
end
