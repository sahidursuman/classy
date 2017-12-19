class AddLogoInCentes < ActiveRecord::Migration[5.1]
  def change
    add_column :centers, :logo, :string
    add_column :centers, :email, :string
    add_column :centers, :phone_number, :string
  end
end
