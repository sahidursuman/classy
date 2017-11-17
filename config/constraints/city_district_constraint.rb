class CityDistrictConstraint
  attr_reader :condition

  def initialize condition
    @condition = condition
  end 

  def matches? request
    valid_full_location?(request) && condition.matches?(request)
  end

  private
  def valid_full_location? request
    City.exists?(key_name: request[:city_name]) &&
      District.exists?(key_name: request[:district_name])
  end
end
