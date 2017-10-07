class CreateTrainingCenterManagements < ActiveRecord::Migration[5.1]
  def change
    create_table :training_center_managements do |t|
      t.references :training_center, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
