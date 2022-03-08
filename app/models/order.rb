class Order < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  has_many :users, through: :tables
  belongs_to :table
end
