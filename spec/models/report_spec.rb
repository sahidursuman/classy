require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:reportable)}
    it {is_expected.to belong_to(:user)}
  end

  describe "validates presence" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:reportable_id) }
    it { should validate_presence_of(:status) }
  end

  describe "validates length" do
    it { should validate_length_of(:content).is_at_most(Settings.validations.report.content.max_length) }
    it { should validate_length_of(:content).is_at_least(Settings.validations.report.content.min_length) }
  end
end
