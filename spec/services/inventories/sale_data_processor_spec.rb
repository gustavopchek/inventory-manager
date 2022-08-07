require "rails_helper"

RSpec.describe Inventories::SaleDataProcessor do
  describe "#call" do
    let(:sale_data) do
      "{\"store\":\"ALDO Destiny USA Mall\",\"model\":\"ABOEN\",\"inventory\":15}"
    end

    let!(:store) { create(:store, uid: "aldo_destiny_usa_mall") }
    let!(:product) { create(:product, uid: "aboen") }

    subject { described_class.new.call(sale_data) }

    it "broadcasts update and alert" do
      expect(Turbo::StreamsChannel).to receive(:broadcast_prepend_to).with(
        "inventory",
        target: "inventory",
        partial: "dashboard/sale",
        locals: {
          inventory: an_instance_of(Inventory),
          received_at: anything,
          store_name: store.name,
          model_name: product.name,
          inventory_amount: 15
        }
      )

      expect(Turbo::StreamsChannel).to receive(:broadcast_prepend_to).with(
        "inventory",
        target: "alerts",
        partial: "dashboard/alert",
        locals: {
          inventory: an_instance_of(Inventory),
          received_at: Time.current.to_formatted_s(:short),
          store_name: store.name,
          model_name: product.name,
          inventory_amount: 15,
          alert_level: "primary"
        }
      )

      subject
    end

    context "when inventory object does not exist" do
      it "creates inventory object with correct information", :aggregate_failures do
        expect { subject }.to change { Inventory.count }.by(1)

        last_inventory = Inventory.last

        expect(last_inventory.store.uid).to eq(store.uid)
        expect(last_inventory.product.uid).to eq(product.uid)
        expect(last_inventory.amount).to eq(15)
      end
    end

    context "when inventory already exists" do
      let(:inventory) { create(:inventory, store: store, product: product, amount: 10) }

      it "updates inventory amount" do
        expect { subject }.to change { inventory.reload.amount }.from(10).to(15)
      end
    end
  end
end
