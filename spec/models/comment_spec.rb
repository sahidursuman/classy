require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:review)}
    it {is_expected.to belong_to(:branch)}
  end
end
