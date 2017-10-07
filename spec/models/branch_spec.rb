require "rails_helper"

RSpec.describe Branch, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:training_center)}
    it {is_expected.to belong_to(:city)}
    it {is_expected.to belong_to(:district)}
    it {is_expected.to have_many(:branch_managements)}
    it {is_expected.to have_many(:reviews)}
    it {is_expected.to have_many(:comments)}
  end
end
