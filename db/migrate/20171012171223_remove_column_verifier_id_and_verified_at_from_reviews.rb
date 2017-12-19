class RemoveColumnVerifierIdAndVerifiedAtFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :verifier_id
    remove_column :reviews, :verified_at
  end
end
