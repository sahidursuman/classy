class City < ApplicationRecord
  include FriendlyUrl

  has_many :districts
  has_many :branches

  acts_as_url :name, url_attribute: :slug, sync_url: true
end
