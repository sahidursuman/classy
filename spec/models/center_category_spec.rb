require "rails_helper"

RSpec.describe CenterCategory, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:category)}
    it {is_expected.to belong_to(:center)}
  end
end
