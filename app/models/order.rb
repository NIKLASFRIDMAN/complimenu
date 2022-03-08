class Order < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :table
end
