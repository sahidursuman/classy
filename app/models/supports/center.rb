class Supports::Center
  attr_reader :center

  def initialize center
    @center = center
  end

  def city_options
    @city_options ||= center.cities.pluck :name, :key_name
  end

  def active_branches_city_options
    @active_branches_city_options ||= center.active_branches_cities.priority_desc
      .pluck(:name, :key_name).uniq
  end

  def center_category_options
    @center_category_options ||= CenterCategory.priority_desc.pluck :name, :id
  end
end
