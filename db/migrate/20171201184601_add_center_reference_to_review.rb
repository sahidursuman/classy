class AddCenterReferenceToReview < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :center, foreign_key: true
    add_column :reviews, :phone_number_verifiable, :string
    add_column :reviews, :email_verifiable, :string
  end
end
