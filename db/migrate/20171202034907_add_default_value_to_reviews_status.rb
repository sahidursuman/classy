class AddDefaultValueToReviewsStatus < ActiveRecord::Migration[5.1]
  def change
    change_column_default :reviews, :status, 0
  end
end
