class ChangeSeparateColumnCoordinatesIntoLatlonFromBranches < ActiveRecord::Migration[5.1]
  def change
    remove_column :branches, :coordinates
    add_column :branches, :latitude, :float
    add_column :branches, :longitude, :float
  end
end
