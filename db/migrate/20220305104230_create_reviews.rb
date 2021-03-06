class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :upvote
      t.integer :downvote
      t.references :item, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
