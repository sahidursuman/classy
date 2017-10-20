class CenterComment < Comment
  belongs_to :branch
  belongs_to :user
end
