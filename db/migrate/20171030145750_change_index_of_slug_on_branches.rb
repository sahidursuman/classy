class ChangeIndexOfSlugOnBranches < ActiveRecord::Migration[5.1]
  def change
    remove_index :branches, :slug
    add_index :branches, [:center_id, :slug], unique: true
  end
end
