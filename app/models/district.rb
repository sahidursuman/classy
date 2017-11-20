class District < ApplicationRecord
  belongs_to :city
  has_many :branches

  scope :priority_desc, ->{order priority: :desc}
  
  acts_as_url :name, url_attribute: :key_name, scope: :city_id, sync_url: true,
    callback_method: :before_save

  friendly_findable :key_name
end
