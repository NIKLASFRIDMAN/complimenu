class Item < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  validates :name, presence: true
  validates :category, presence: true
end
