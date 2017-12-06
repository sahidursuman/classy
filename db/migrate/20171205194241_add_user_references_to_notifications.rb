class AddUserReferencesToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_reference :notifications, :user
    add_column :notifications, :data, :string
  end
end
