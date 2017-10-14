require "rails_helper"

RSpec.describe Supports::TrainingCenter do
  let(:training_center){double Center}
  let(:support){Supports::TrainingCenter.new training_center}

  describe "#city_options" do
    let(:city_ids){double Array}
    before do
      allow(training_center).to receive_message_chain(:active_branches, :pluck)
        .with(no_args).with(:city_id){city_ids}
    end
    it do
      expect(City).to receive_message_chain(:by_ids, :pluck).with(city_ids).with(:name, :slug)
      support.city_options
    end
  end
end
