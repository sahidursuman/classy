class ApplicationDecorator < Draper::Decorator
  extend Paginatable

  delegate_all
end
