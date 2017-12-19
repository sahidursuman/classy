require "rails_helper"

RSpec.describe User, type: :model do
  # let(:user) {FactoryBot.create :user}
  # subject {user}
  #
  describe "association" do
    it {is_expected.to have_one(:center_management)}
    it {is_expected.to have_many(:branch_managements)}
    it {is_expected.to have_many(:center_requests)}
    it {is_expected.to have_many(:reviews)}
    it {is_expected.to have_many(:votes)}
    it {is_expected.to have_many(:comments)}
  end

  describe "validation" do
    it {is_expected.to validate_presence_of :first_name}
    it {is_expected.to validate_presence_of :last_name}
    it {is_expected.to validate_presence_of :role}
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_presence_of :password}
    it {is_expected.to validate_length_of(:first_name).is_at_most 30}
    it {is_expected.to validate_length_of(:last_name).is_at_most 30}
    it {is_expected.to validate_length_of(:password).is_at_least(6).is_at_most 128}
  end
end
