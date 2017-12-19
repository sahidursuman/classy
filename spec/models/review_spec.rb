require "rails_helper"

RSpec.describe Review, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:branch)}
    it {is_expected.to have_many(:comments)}
    it {is_expected.to have_many(:votes)}
    it {is_expected.to have_many(:review_verifications)}
  end
end
