require "rails_helper"

RSpec.describe User, type: :model do
  # let(:user) {FactoryGirl.create :user}
  # subject {user}
  #
  describe "association" do
    it {is_expected.to have_one(:training_center_management)}
    it {is_expected.to have_many(:branch_managements)}
    it {is_expected.to have_many(:training_center_requests)}
    it {is_expected.to have_many(:training_center_requests)}
    it {is_expected.to have_many(:reviews)}
    it {is_expected.to have_many(:votes)}
  end
end
