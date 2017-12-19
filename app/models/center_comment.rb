class CenterComment < Comment
  has_one :center, through: :review
end
