class Order < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  belongs_to :table
end
