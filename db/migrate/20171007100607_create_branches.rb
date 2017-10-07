class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.references :training_center, foreign_key: true
      t.string :name
      t.string :avatar
      t.integer :status
      t.float :cached_avarage_rating
      t.text :description
      t.references :city, foreign_key: true
      t.references :district, foreign_key: true
      t.string :address
      t.column :coordinates, :point
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
