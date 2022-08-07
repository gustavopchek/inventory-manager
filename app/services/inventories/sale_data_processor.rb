class Inventories::SaleDataProcessor
  def call(sale_data)
    parsed_data = JSON.parse(sale_data).with_indifferent_access

    @store = Store.find_by!(uid: parsed_data[:store].underscore.gsub(" ", "_"))
    @product = Product.find_by!(uid: parsed_data[:model].underscore.gsub(" ", "_"))

    @inventory = Inventory.find_or_initialize_by(
      store: store,
      product: product
    )

    inventory.amount = parsed_data[:inventory]
    inventory.save!

    broadcast_inventory_update
  rescue ActiveRecord::RecordNotFound => e
    pp e.message
  end

  private

  attr_accessor :store, :product, :inventory

  def broadcast_inventory_update
    Turbo::StreamsChannel.broadcast_prepend_to(
      "inventory",
      target: "inventory",
      partial: "dashboard/sale",
      locals: {
        inventory: inventory,
        received_at: Time.current.to_formatted_s(:short),
        store_name: store.name,
        model_name: product.name,
        inventory_amount: inventory.amount
      }
    )

    # as we are passing an "id", there will be no duplicates
    if inventory.amount <= 15
      broadcast_alert
      Inventories::StockFinderJob.perform_async(inventory.product_id) if inventory.amount.zero?
    else
      Turbo::StreamsChannel.broadcast_remove_to("inventory", target: "alert_#{ActionView::RecordIdentifier.dom_id(inventory)}")
    end
  end

  def broadcast_alert
    Turbo::StreamsChannel.broadcast_prepend_to(
      "inventory",
      target: "alerts",
      partial: "dashboard/alert",
      locals: {
        inventory: inventory,
        received_at: Time.current.to_formatted_s(:short),
        store_name: store.name,
        model_name: product.name,
        inventory_amount: inventory.amount,
        alert_level: alert_level_by_inventory(inventory.amount)
      }
    )
  end

  def alert_level_by_inventory(amount)
    case amount
    when 0 then "danger"
    when 1..5 then "warning"
    when 6..10 then "info"
    else "primary"
    end
  end
end
