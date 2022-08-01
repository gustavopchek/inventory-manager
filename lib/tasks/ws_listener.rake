task ws_listener: :environment do
  require "faye/websocket"
  require "eventmachine"
  require "json"

  EM.run {
    ws = Faye::WebSocket::Client.new("ws://localhost:8080/")

    ws.on :message do |event|
      # turbo_stream.replace "inventory_1", partial: "users/display/#{@partial}"
      # ActionCable.server.broadcast 'inventory_channel', message: ApplicationController.renderer.render(partial: 'inventories/sale', locals: { data: event.data })
      Inventories::SaleDataProcessor.new.call(event.data)
    end
  }
end
