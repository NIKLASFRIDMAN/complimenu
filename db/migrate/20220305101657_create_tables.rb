class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :tables do |t|

      t.timestamps
    end
  end
end
