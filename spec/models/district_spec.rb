require "rails_helper"

RSpec.describe District, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:city)}
    it {is_expected.to have_many(:branches)}
  end
end
