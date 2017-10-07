class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :branch, foreign_key: true
      t.string :title
      t.text :content
      t.float :average_rating
      t.integer :rating_criteria_1
      t.integer :rating_criteria_2
      t.integer :rating_criteria_3
      t.integer :rating_criteria_4
      t.integer :rating_criteria_5
      t.integer :status
      t.string :email_verify
      t.string :phone_number_verify
      t.integer :verifier_id
      t.datetime :verified_at
      t.string :note
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
