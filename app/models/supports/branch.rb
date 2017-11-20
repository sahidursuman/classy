class Supports::Branch
  attr_reader :branch

  def initialize branch
    @branch = branch
  end

  def city_options
    @city_options ||= City.pluck :name, :id
  end

  def district_options
    @district_options ||= if branch.city.present?
      branch.city.districts.priority_desc.pluck :name, :id
    else
      []
    end
  end
end
