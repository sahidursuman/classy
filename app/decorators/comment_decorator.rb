class CommentDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  delegate_all

  def content
    simple_format strip_tags object.content
  end
end
