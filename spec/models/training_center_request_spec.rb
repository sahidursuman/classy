require "rails_helper"

RSpec.describe TrainingCenterRequest, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:user)}
  end
end
