class AddPriorityToMasterData < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :priority, :integer, default: 0
    add_column :districts, :priority, :integer, default: 0
    add_column :categories, :priority, :integer, default: 0
  end
end
