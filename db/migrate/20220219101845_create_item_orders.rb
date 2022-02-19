class CreateItemOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :item_orders do |t|
      t.integer :quantity
      t.references :item, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
