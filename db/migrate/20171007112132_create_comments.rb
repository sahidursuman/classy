class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :type
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
      t.references :branch, foreign_key: true
      t.text :content
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
