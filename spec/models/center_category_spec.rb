require "rails_helper"

RSpec.describe CenterCategory, type: :model do
  describe "association" do
    it {is_expected.to have_many(:centers)}
    it {is_expected.to have_many(:course_categories)}
  end
end
