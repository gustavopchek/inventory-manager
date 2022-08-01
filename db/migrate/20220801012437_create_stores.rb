class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :uid, index: { unique: true }

      t.timestamps
    end
  end
end
