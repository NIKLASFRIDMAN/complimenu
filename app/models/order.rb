class Order < ApplicationRecord
  has_many :item_order, dependent: :destroy
end
