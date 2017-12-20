require "rails_helper"

RSpec.describe CourseClassification, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:course)}
  end
end
