require "rails_helper"

RSpec.describe City, type: :model do
  describe "association" do
    it {is_expected.to have_many(:districts)}
    it {is_expected.to have_many(:branches)}
  end
end
