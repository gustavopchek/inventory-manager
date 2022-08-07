# README

**Inventory Manager** is a dashboard to monitor sales info coming from a websocket.

## Features
- Built using Rails 6
- Bulma framework for dashboard view
- Hotwire/Turbo to update dashboard view
- Eventmachine to listen to Websocket (in a rake task)
- Sidekiq and Sidekiq Cron for background processing
- RSpec, FactoryBot and Faker for testing


## Instructions
- Make sure websocket is running `bin/websocketd --port=8080 ruby inventory.rb` on **shoe-store** repo
- On this repo, in a separate terminal, run `rake ws_listener` to connect to websocket and receive events
- In another terminal window, run `bundle exec sidekiq -C config/sidekiq.rb` to start Sidekiq
- Run `rails s` to start Rails server
- Open *http://localhost:3000/dashboard* to open the inventory dashboard


The dashboard page should look similar to this

![alt text](dashboard.jpg)

The dashboard contains two main tables: the first one lists the update logs. A log for a same product in a same store will not be duplicated (it will be replaced). And the second one contains alerts when inventory amount is low, along with suggestions and minute digests with custom inventory information.



### Cron Jobs
- Some jobs are scheduled on *config/schedule.yml*. They execute some actions and send updates to dashboard.
