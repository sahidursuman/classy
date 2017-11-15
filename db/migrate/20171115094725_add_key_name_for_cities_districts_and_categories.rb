class AddKeyNameForCitiesDistrictsAndCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :key_name, :string, unique: true
    add_column :districts, :key_name, :string
    add_column :categories, :key_name, :string

    add_index :cities, :key_name
    add_index :districts, [:city_id, :key_name], unique: true
    add_index :categories, [:parent_id, :key_name], unique: true
  end
end
