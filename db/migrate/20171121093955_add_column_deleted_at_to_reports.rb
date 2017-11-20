class AddColumnDeletedAtToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :deleted_at, :datetime
    add_index :reports, :deleted_at, where: "deleted_at IS NULL"
  end
end
