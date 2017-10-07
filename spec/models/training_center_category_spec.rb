require "rails_helper"

RSpec.describe TrainingCenterCategory, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:category)}
    it {is_expected.to belong_to(:training_center)}
  end
end
