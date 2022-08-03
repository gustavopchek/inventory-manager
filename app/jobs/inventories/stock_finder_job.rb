class Inventories::StockFinderJob
  include Sidekiq::Job

  sidekiq_options queue: :inventory

  def perform(product_id)
    inventories = Inventory.where(product_id: product_id).where("amount > ?", 0)
    pp "performing stock finder job"

    store_names = inventories.map {|iv| iv.store.name }.join(", ")

    Turbo::StreamsChannel.broadcast_prepend_to(
      "inventory",
      target: "alerts",
      partial: "dashboard/stock_finder",
      locals: {
        product_name: inventories.first.product.name,
        store_names: store_names,
        generated_at: Time.current.to_formatted_s(:short)
      }
    )
  end
end
