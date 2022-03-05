class Order < ApplicationRecord
  has_many :item_order, :reviews, dependent: :destroy
end
