class CommentDecorator < ApplicationDecorator
  include ActionView::Helpers::TextHelper

  delegate_all

  decorates_association :user

  def content
    simple_format strip_tags object.content
  end

  def owner_name
    if object.is_a? UserComment
      user.full_name
    else
      branch.name
    end
  end
end
