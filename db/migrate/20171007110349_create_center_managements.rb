class CreateCenterManagements < ActiveRecord::Migration[5.1]
  def change
    create_table :center_managements do |t|
      t.references :center, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
