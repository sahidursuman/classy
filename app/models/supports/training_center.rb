class Supports::TrainingCenter
  attr_reader :training_center

  def initialize training_center
    @training_center = training_center
  end

  def city_options
    @cities = City.by_ids(training_center.active_branches.pluck :city_id)
      .pluck :name, :slug
  end
end
