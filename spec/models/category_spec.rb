require "rails_helper"

RSpec.describe Category, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:parent_category)}
    it {is_expected.to have_many(:child_categories)}
  end

  describe "validates presence" do
    it { should validate_uniqueness_of(:key_name).case_insensitive }
  end
end
