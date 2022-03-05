class AddTableToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :table, null: false, foreign_key: true
  end
end
