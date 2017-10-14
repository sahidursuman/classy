require "rails_helper"

RSpec.describe Center, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:training_type)}
    it {is_expected.to have_many(:center_managements)}
    it {is_expected.to have_many(:branches)}
    it {is_expected.to have_many(:center_categories)}
  end
end
