class ReviewDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  delegate :full_name, to: :user, prefix: true
end
