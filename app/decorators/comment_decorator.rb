class CommentDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  def content
    simple_format strip_tags object.content
  end
end
