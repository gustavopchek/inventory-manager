class Inventories::AmountCounterJob
  include Sidekiq::Job

  sidekiq_options queue: :inventory

  def perform
    inventories = Inventory.where("amount < ?", 10)
    pp "performing amount counter job"

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
