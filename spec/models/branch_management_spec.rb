require "rails_helper"

RSpec.describe BranchManagement, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:branch)}
    it {is_expected.to belong_to(:user)}
  end
end
