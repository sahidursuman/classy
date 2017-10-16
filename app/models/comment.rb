class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  belongs_to :branch, optional: true

  scope :earlier_created, ->{order created_at: :asc}

  acts_as_paranoid
end
