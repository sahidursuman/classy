require "rails_helper"

RSpec.describe CenterComment, type: :model do
  describe "association" do
    it {is_expected.to have_one(:center)}
  end
end
