class Inventory < ApplicationRecord
  belongs_to :product
  belongs_to :store
end
