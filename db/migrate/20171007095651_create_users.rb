class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :avatar
      t.string :phone_number
      t.integer :role

      t.timestamps
    end
  end
end
