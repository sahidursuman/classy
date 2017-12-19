class AddCreatableReferencesToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_reference :notifications, :creatable, polymorphic: true
  end
end
