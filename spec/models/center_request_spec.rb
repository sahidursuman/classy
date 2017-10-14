require "rails_helper"

RSpec.describe CenterRequest, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:user)}
  end
end
