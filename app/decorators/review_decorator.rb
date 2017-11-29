class ReviewDecorator < ApplicationDecorator
  attr_accessor :voted_type

  include Draper::LazyHelpers

  decorates_association :user

  delegate :full_name, to: :user, prefix: true

  def content
    simple_format strip_tags object.content
  end

  def show_comments?
    comments_count > 0
  end

  def current_user_voted_type
    voted_type || object.try(:voted_type)
  end
end
