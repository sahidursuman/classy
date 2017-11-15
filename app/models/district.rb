class District < ApplicationRecord
  belongs_to :city
  has_many :branches

  acts_as_url :name, url_attribute: :key_name, scope: :city_id, sync_url: true,
    callback_method: :before_save

  friendly_finable :key_name
end
