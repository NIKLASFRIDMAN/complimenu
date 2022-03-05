class Item < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :category, presence: true
end
