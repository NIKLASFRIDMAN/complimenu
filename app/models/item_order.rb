class ItemOrder < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :item
  belongs_to :order
  
  # SCOPES
  scope :grouped_by_item, ->(order_id) {
    joins(:item)
    .where(order_id: order_id)
    .group_by { |item_order| item_order.item.id }
  }
end
