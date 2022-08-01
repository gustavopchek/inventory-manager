class Inventories::AmountCounterJob
  include Sidekiq::Job

  def perform(*args)
    inventories = Inventory.where("amount < ?", 10)

    Turbo::StreamsChannel.broadcast_prepend_to(
      "inventory",
      target: "alerts",
      partial: "dashboard/custom_alert",
      locals: {
        item_count: inventories.count,
        generated_at: Time.current.to_formatted_s(:short)
      }
    )
  end
end
