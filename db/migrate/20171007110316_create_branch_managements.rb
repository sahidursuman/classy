class CreateBranchManagements < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_managements do |t|
      t.references :branch, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
