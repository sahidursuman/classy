require "rails_helper"

RSpec.describe ReviewVerification, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:review)}
  end
end
