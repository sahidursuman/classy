require "rails_helper"

RSpec.describe TrainingType, type: :model do
  describe "association" do
    it {is_expected.to have_many(:training_centers)}
    it {is_expected.to have_many(:categories)}
  end
end
