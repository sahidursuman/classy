class CenterCommentDecorator < CommentDecorator
  decorates_association :branch
  
  delegate :full_name, to: :branch, prefix: :owner
  
  def owner_path
    branch_path branch.route_params
  end
end
