class AddSlugToDistricts < ActiveRecord::Migration[5.1]
  def change
    add_column :districts, :slug, :string
    add_index :districts, [:city_id, :slug], unique: true
  end
end
