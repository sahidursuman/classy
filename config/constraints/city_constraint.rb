class CityConstraint
  attr_reader :condition

  def initialize condition
    @condition = condition
  end 

  def matches? request
    City.exists?(key_name: request[:city_name]) && condition.matches?(request)
  end
end
