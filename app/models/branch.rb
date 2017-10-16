class Branch < ApplicationRecord
  include FriendlyUrl

  belongs_to :center
  belongs_to :city
  belongs_to :district
  has_many :branch_managements
  has_many :branch_managers, through: :branch_managements, source: :user
  has_many :reviews
  has_many :comments

  enum status: [:active, :inactive]

  acts_as_url :name, url_attribute: :slug, sync_url: true

  delegate :name, to: :center, prefix: true, allow_nil: true
end
