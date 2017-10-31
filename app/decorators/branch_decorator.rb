class BranchDecorator < ApplicationDecorator
  delegate_all

  def full_name
    center_name + " - " + name
  end
end
