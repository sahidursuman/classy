class City < ApplicationRecord
  has_many :districts
  has_many :branches

  scope :by_ids, ->ids{where id: ids}
  scope :priority_desc, ->{order priority: :desc}

  acts_as_url :name, url_attribute: :key_name, sync_url: true, callback_method: :before_save

  friendly_findable :key_name
end
