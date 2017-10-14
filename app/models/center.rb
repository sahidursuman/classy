class Center < ApplicationRecord
  include FriendlyUrl

  belongs_to :training_type
  has_many :center_managements
  has_many :branches
  has_many :center_categories
  has_many :active_branches, ->{active}, class_name: Branch.name

  enum status: [:active, :inactive]

  acts_as_url :name, url_attribute: :slug, sync_url: true
end
