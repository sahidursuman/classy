class City < ApplicationRecord
  include FriendlyUrl

  has_many :districts
  has_many :branches

  scope :by_ids, ->ids{where id: ids}

  acts_as_url :name, url_attribute: :slug, sync_url: true
end
