class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.references :product
      t.references :store
      t.integer :amount, null: false, default: 0

      t.index [:product_id, :store_id], unique: true

      t.timestamps
    end
  end
end
