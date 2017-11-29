class CenterDecorator < ApplicationDecorator
  extend Paginatable

  def city_names
    cities.pluck(:name).join ", "
  end
end
