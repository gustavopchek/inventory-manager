class InventoryChannel < ApplicationCable::Channel
  def subscribed
    stream_from "inventory_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def sync
  end
end
