require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "association" do
    it {is_expected.to belong_to(:notifiable)}
    it {is_expected.to belong_to(:creatable)}
  end
end
