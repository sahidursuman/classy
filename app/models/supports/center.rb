class Supports::Center
  attr_reader :center

  def initialize center
    @center = center
  end

  def city_options
    @city_options ||= center.cities.pluck :name, :slug
  end

  def active_branches_city_options
    @active_branches_city_options ||= center.active_branches_cities.pluck :name, :slug
  end

  def training_type_options
    @training_type_options ||= TrainingType.pluck :name, :id
  end
end
