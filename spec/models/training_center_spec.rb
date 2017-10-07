require "rails_helper"

RSpec.describe TrainingCenter, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:training_type)}
    it {is_expected.to have_many(:training_center_managements)}
    it {is_expected.to have_many(:branches)}
    it {is_expected.to have_many(:training_center_categories)}
  end
end
