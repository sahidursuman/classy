require "rails_helper"

RSpec.describe Course, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:center)}
    it {is_expected.to belong_to(:course_category)}
    it {is_expected.to have_many(:course_classifications)}
    it {is_expected.to have_many(:course_sub_categories)}
  end


  describe "validates presence" do
    it { should validate_presence_of(:category_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:intended_student) }
    it { should validate_presence_of(:sessions) }
    it { should validate_presence_of(:duration) }
  end

  describe "validates length" do
    it { should validate_length_of(:name).is_at_most(Settings.validations.course.name.max_length) }
    it { should validate_length_of(:intended_student).is_at_most(Settings.validations.course.description.max_length) }
    it { should validate_length_of(:curriculum).is_at_most(Settings.validations.center.description.max_length) }
  end
end
