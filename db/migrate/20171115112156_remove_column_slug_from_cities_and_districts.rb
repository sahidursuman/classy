class RemoveColumnSlugFromCitiesAndDistricts < ActiveRecord::Migration[5.1]
  def change
    remove_column :cities, :slug
    remove_column :districts, :slug
  end
end
