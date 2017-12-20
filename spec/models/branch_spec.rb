require "rails_helper"

RSpec.describe Branch, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:center)}
    it {is_expected.to belong_to(:city)}
    it {is_expected.to belong_to(:district)}
    it {is_expected.to have_many(:reviews)}
  end

  describe "validates presence" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city_id) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone_number) }
  end

  describe "validates length" do
    it { should validate_length_of(:name).is_at_most(Settings.validations.branch.name.max_length) }
    it { should validate_length_of(:address).is_at_most(Settings.validations.branch.address.max_length) }
  end
end
