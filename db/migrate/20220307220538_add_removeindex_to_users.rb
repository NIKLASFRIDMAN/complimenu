class AddRemoveindexToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, column: :email
  end
end
