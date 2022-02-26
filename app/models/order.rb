class Order < ApplicationRecord
  has_many :item_orders, dependent: :destroy
end
