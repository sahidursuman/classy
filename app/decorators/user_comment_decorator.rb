class UserCommentDecorator < CommentDecorator
  decorates_association :user

  delegate :full_name, to: :user, prefix: :owner

  def owner_path
    user
  end
end
