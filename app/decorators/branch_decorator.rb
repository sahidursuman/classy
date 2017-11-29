class BranchDecorator < ApplicationDecorator
  def full_name
    center_name + " - " + name
  end
end
