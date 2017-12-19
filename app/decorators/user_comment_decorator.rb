class UserCommentDecorator < CommentDecorator
  decorates_association :user

  def owner_path
    user
  end

  def owner_name
    user.full_name
  end

  def owner
    user
  end
end
