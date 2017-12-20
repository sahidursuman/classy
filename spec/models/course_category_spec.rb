require "rails_helper"

RSpec.describe CourseCategory, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:center_category)}
    it {is_expected.to have_many(:course_sub_categories)}
    it {is_expected.to have_many(:courses)}
  end
end
