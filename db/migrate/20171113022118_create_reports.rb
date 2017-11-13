class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.references :user, foreign_key: true
      t.text :content
      t.bigint :reportable_id
      t.string :reportable_type
      t.integer :status, default: 0
      t.text :response_message

      t.timestamps
    end
  end
end
