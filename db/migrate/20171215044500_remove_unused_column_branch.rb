class RemoveUnusedColumnBranch < ActiveRecord::Migration[5.1]
  def change
    remove_column :branches, :avatar, :string
    remove_column :branches, :cached_avarage_rating, :float
    remove_column :branches, :description, :text
  end
end
