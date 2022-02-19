class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0, null: false
      t.datetime :time_delivered
      t.datetime :time_ordered
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
