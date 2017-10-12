class AddSlugToBranches < ActiveRecord::Migration[5.1]
  def change
    add_column :branches, :slug, :string
    add_index :branches, :slug, unique: true
  end
end
