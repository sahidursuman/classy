require "rails_helper"

RSpec.describe Review, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:center)}
    it {is_expected.to belong_to(:branch)}
    it {is_expected.to have_many(:comments)}
    it {is_expected.to have_many(:votes)}
    it {is_expected.to have_many(:reports)}
    it {is_expected.to have_many(:created_notifications)}
  end

  describe "validates presence" do

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:rating_criterion_1) }
    it { should validate_presence_of(:rating_criterion_2) }
    it { should validate_presence_of(:rating_criterion_3) }
    it { should validate_presence_of(:rating_criterion_4) }
    it { should validate_presence_of(:rating_criterion_5) }
    it { should validate_presence_of(:email_verifiable) }
    it { should validate_presence_of(:phone_number_verifiable) }
  end

  describe "validates length" do
    it { should validate_length_of(:title).is_at_least(Settings.validations.review.title.min_length) }
    it { should validate_length_of(:title).is_at_most(Settings.validations.review.title.max_length) }
    it { should validate_length_of(:content).is_at_least(Settings.validations.review.content.min_length) }
    it { should validate_length_of(:content).is_at_most(Settings.validations.review.content.max_length) }
    it { should validate_length_of(:email_verifiable).is_at_most(Settings.validations.review.email.max_length) }
  end
end
