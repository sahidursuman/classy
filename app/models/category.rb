class Category < ApplicationRecord
  belongs_to :parent_category, class_name: Category.name, foreign_key: :parent_id,
    optional: true
  has_many :child_categories, class_name: Category.name, foreign_key: :parent_id

  scope :by_ids, ->(ids){where id: ids}

  acts_as_url :name, url_attribute: :key_name, scope: :parent_id, sync_url: true, 
    callback_method: :before_save

  friendly_findable :key_name

  class << self
    def by_key_names key_names
      last_key_name = key_names.pop
      key_names.inject(self) do |association, key_name|
        association.find_by(key_name: key_name).child_categories
      end.find_by key_name: last_key_name 
    rescue
      nil
    end
  end
end
