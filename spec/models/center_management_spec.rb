require "rails_helper"

RSpec.describe CenterManagement, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:center)}
    it {is_expected.to belong_to(:user)}
  end
end
