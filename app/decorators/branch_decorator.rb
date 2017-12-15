class BranchDecorator < ApplicationDecorator
  def full_name
    center_name + " - " + name
  end

  def map_data
    {name: full_name, address: full_address, lat: latitude, long: longitude, phone: phone_number}
  end
end
