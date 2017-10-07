class CreateTrainingCenterRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :training_center_requests do |t|
      t.references :user, foreign_key: true
      t.string :training_center_name
      t.string :reference_website
      t.string :reference_fanpage
      t.string :phone_number
      t.integer :status

      t.timestamps
    end
  end
end
