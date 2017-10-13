class RemoveColumnEmailAndPhoneNumberVerifyFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :email_verify
    remove_column :reviews, :phone_number_verify
    remove_column :reviews, :note
  end
end
