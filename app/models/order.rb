class Order < ApplicationRecord
  has_many :item_orders
end
