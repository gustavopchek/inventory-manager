require "rails_helper"

RSpec.describe Inventories::AmountCounterJob do
  describe "#perform" do
    let!(:inventory_1) { create(:inventory, amount: 5) }
    let!(:inventory_2) { create(:inventory, amount: 8) }
    let!(:inventory_3) { create(:inventory, amount: 11) }

    it "broadcasts inventory info" do
      expect(Turbo::StreamsChannel).to receive(:broadcast_prepend_to).with(
        "inventory",
        target: "alerts",
        partial: "dashboard/custom_alert",
        locals: {
          item_count: 2,
          generated_at: anything
        }
      )

      described_class.new.perform
    end
  end
end
