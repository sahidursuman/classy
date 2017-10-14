require "rails_helper"

RSpec.describe TrainingType, type: :model do
  describe "association" do
    it {is_expected.to have_many(:centers)}
    it {is_expected.to have_many(:categories)}
  end
end
