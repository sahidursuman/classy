class AddNormalizeNameToCenters < ActiveRecord::Migration[5.1]
  def change
    add_column :centers, :normalized_name, :string
  end
end
