class District < ApplicationRecord
  include FriendlyUrl

  belongs_to :city
  has_many :branches

  acts_as_url :name, url_attribute: :slug, scope: :city_id, sync_url: true
end
