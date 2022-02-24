class Item < ApplicationRecord
  has_many :item_orders
  validates :name, presence: true
  validates :category, presence: true
end
