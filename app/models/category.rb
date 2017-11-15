class Category < ApplicationRecord
  scope :by_ids, ->(ids){where id: ids}
end
