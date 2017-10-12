class Branch < ApplicationRecord
  include FriendlyUrl

  belongs_to :training_center
  belongs_to :city
  belongs_to :district
  has_many :branch_managements
  has_many :reviews
  has_many :comments

  enum status: [:active, :inactive]

  acts_as_url :name, url_attribute: :slug, sync_url: true

  delegate :name, to: :training_center, prefix: true, allow_nil: true
end
