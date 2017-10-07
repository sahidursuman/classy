require "rails_helper"

RSpec.describe TrainingCenterManagement, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:training_center)}
    it {is_expected.to belong_to(:user)}
  end
end
