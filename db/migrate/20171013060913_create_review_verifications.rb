class CreateReviewVerifications < ActiveRecord::Migration[5.1]
  def change
    create_table :review_verifications do |t|
      t.references :review, foreign_key: true
      t.integer :status
      t.string :email
      t.string :phone_number
      t.string :response_message

      t.timestamps
    end
  end
end
