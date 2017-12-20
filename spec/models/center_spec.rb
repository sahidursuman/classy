require "rails_helper"

RSpec.describe Center, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:center_category)}
    it {is_expected.to have_many(:center_managements)}
    it {is_expected.to have_many(:branches)}
    it {is_expected.to have_many(:active_branches)}
    it {is_expected.to have_many(:cities)}
    it {is_expected.to have_many(:active_branches_cities)}
    it {is_expected.to have_many(:reviews)}
    it {is_expected.to have_many(:courses)}
    it {is_expected.to have_many(:reports)}
    it {is_expected.to have_many(:notifications)}
    it {is_expected.to have_many(:managers)}
    it {is_expected.to have_many(:course_categories)}

  end

  describe "validates presence" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category_id) }
    it { should validate_presence_of(:overview) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone_number) }
  end

  describe "validates length" do
    it { should validate_length_of(:name).is_at_most(Settings.validations.branch.name.max_length) }
    it { should validate_length_of(:overview).is_at_most(Settings.validations.center.description.max_length) }
    it { should validate_length_of(:curriculum_overview).is_at_most(Settings.validations.center.description.max_length) }
    it { should validate_length_of(:email).is_at_most(Settings.validations.center.email.max_length) }
  end
end
