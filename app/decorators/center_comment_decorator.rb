class CenterCommentDecorator < CommentDecorator
  delegate :name, to: :center, prefix: :owner

  def owner_path
    center_path center.route_params
  end

  def owner
    center
  end
end
