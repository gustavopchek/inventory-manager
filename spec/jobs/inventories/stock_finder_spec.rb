require "rails_helper"

RSpec.describe Inventories::StockFinderJob do
  describe "#perform" do
    let!(:product) { create(:product) }

    let!(:store_1) { create(:store) }
    let!(:store_2) { create(:store) }
    let!(:store_3) { create(:store) }

    let!(:inventory_1) { create(:inventory, store: store_1, product: product, amount: 0) }
    let!(:inventory_2) { create(:inventory, store: store_2, product: product, amount: 15) }
    let!(:inventory_3) { create(:inventory, store: store_3, product: product, amount: 20) }

    it "broadcasts inventory info" do
      expect(Turbo::StreamsChannel).to receive(:broadcast_prepend_to).with(
        "inventory",
        target: "alerts",
        partial: "dashboard/stock_finder",
        locals: {
          product_name: product.name,
          store_names: "#{store_2.name}, #{store_3.name}",
          generated_at: anything
        }
      )

      described_class.new.perform(product.id)
    end
  end
end
