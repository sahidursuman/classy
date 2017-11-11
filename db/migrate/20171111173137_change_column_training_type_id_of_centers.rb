class ChangeColumnTrainingTypeIdOfCenters < ActiveRecord::Migration[5.1]
  def change
    remove_column :centers, :training_type_id
    add_reference :centers, :category, index: true, foreign_key: true
  end
end
