class RenameColumnCriteriaToCriterion < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :rating_criteria_1, :rating_criterion_1
    rename_column :reviews, :rating_criteria_2, :rating_criterion_2
    rename_column :reviews, :rating_criteria_3, :rating_criterion_3
    rename_column :reviews, :rating_criteria_4, :rating_criterion_4
    rename_column :reviews, :rating_criteria_5, :rating_criterion_5
  end
end
